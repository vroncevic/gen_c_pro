#!/bin/bash
#
# @brief   Generate C project
# @version ver.2.0
# @date    Sun 05 Dec 2021 04:20:14 PM CET
# @company None, free software to use 2021
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
#
UTIL_ROOT=/root/scripts
UTIL_VERSION=ver.1.0
UTIL=${UTIL_ROOT}/sh_util/${UTIL_VERSION}
UTIL_LOG=${UTIL}/log

.    ${UTIL}/bin/devel.sh
.    ${UTIL}/bin/usage.sh
.    ${UTIL}/bin/check_root.sh
.    ${UTIL}/bin/check_tool.sh
.    ${UTIL}/bin/logging.sh
.    ${UTIL}/bin/load_conf.sh
.    ${UTIL}/bin/load_util_conf.sh
.    ${UTIL}/bin/progress_bar.sh

GEN_C_PRO_TOOL=gen_c_pro
GEN_C_PRO_VERSION=ver.2.0
GEN_C_PRO_HOME=${UTIL_ROOT}/${GEN_C_PRO_TOOL}/${GEN_C_PRO_VERSION}
GEN_C_PRO_CFG=${GEN_C_PRO_HOME}/conf/${GEN_C_PRO_TOOL}.cfg
GEN_C_PRO_UTIL_CFG=${GEN_C_PRO_HOME}/conf/${GEN_C_PRO_TOOL}_util.cfg
GEN_C_PRO_LOGO=${GEN_C_PRO_HOME}/conf/${GEN_C_PRO_TOOL}.logo
GEN_C_PRO_LOG=${GEN_C_PRO_HOME}/log

tabs 4
CONSOLE_WIDTH=$(stty size | awk '{print $2}')

.    ${GEN_C_PRO_HOME}/bin/center.sh
.    ${GEN_C_PRO_HOME}/bin/display_logo.sh

declare -A GEN_C_PRO_USAGE=(
    [USAGE_TOOL]="${GEN_C_PRO_TOOL}"
    [USAGE_ARG1]="[PROJECT NAME] C Project name"
    [USAGE_EX_PRE]="# Generating C project"
    [USAGE_EX]="${GEN_C_PRO_TOOL} rtp"
)

declare -A GEN_C_PRO_LOGGING=(
    [LOG_TOOL]="${GEN_C_PRO_TOOL}"
    [LOG_FLAG]="info"
    [LOG_PATH]="${GEN_C_PRO_LOG}"
    [LOG_MSGE]="None"
)

declare -A PB_STRUCTURE=(
    [BW]=50
    [MP]=100
    [SLEEP]=0.01
)

TOOL_DBG="false"
TOOL_LOG="false"
TOOL_NOTIFY="false"

#
# @brief   Main function
# @param   Value required project name
# @retval  Function __gen_c_pro exit with integer value
#            0   - tool finished with success operation
#            128 - missing argument(s) from cli
#            129 - failed to load tool script configuration from files
#            130 - failed to load configuration with project set
#            131 - project already exist
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __gen_c_pro "rtp"
#
function __gen_c_pro {
    local PN=$1
    display_logo
    if [ -n "${PN}" ]; then
        local FUNC=${FUNCNAME[0]} MSG="None"
        local STATUS_CONF STATUS_CONF_UTIL STATUS
        MSG="Loading basic and util configuration!"
        info_debug_message "$MSG" "$FUNC" "$GEN_C_PRO_TOOL"
        progress_bar PB_STRUCTURE
        declare -A config_gen_c_pro=()
        load_conf "$GEN_C_PRO_CFG" config_gen_c_pro
        STATUS_CONF=$?
        declare -A config_gen_c_pro_util=()
        load_util_conf "$GEN_C_PRO_UTIL_CFG" config_gen_c_pro_util
        STATUS_CONF_UTIL=$?
        declare -A STATUS_STRUCTURE=(
            [1]=$STATUS_CONF [2]=$STATUS_CONF_UTIL
        )
        check_status STATUS_STRUCTURE
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Force exit!"
            info_debug_message_end "$MSG" "$FUNC" "$GEN_C_PRO_TOOL"
            exit 129
        fi
        TOOL_LOG=${config_gen_c_pro[LOGGING]}
        TOOL_DBG=${config_gen_c_pro[DEBUGGING]}
        TOOL_NOTIFY=${config_gen_c_pro[EMAILING]}
        local V=${config_gen_c_pro_util[VERSION]} DATE=`date` T="	"
        local AN=${config_gen_c_pro_util[AUTHOR_NAME]} BSL="\\" H="#"
        local AE=${config_gen_c_pro_util[AUTHOR_EMAIL]}
        local PROJECT_SET=${config_gen_c_pro_util[PROJECT_SET]} TREE
        local FN="Project created ${DATE}" RMSG="${H} Readme section"
        declare -A project_set=()
        load_util_conf "${GEN_C_PRO_HOME}/conf/${PROJECT_SET}" project_set
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Force exit!"
            info_debug_message_end "$MSG" "$FUNC" "$GEN_C_PRO_TOOL"
            exit 130
        fi
        MSG="Generate project structure!"
        info_debug_message "$MSG" "$FUNC" "$GEN_C_PRO_TOOL"
        if [ -d "${PN}/" ]; then
            MSG="Directory already exist [${PN}]"
            info_debug_message "$MSG" "$FUNC" "$GEN_C_PRO_TOOL"
            MSG="Force exit!"
            info_debug_message_end "$MSG" "$FUNC" "$GEN_C_PRO_TOOL"
            exit 131
        fi
        local CDIR=`pwd`
        local PDIR="${CDIR}/${PN}"
        MSG="Generating directory [${PDIR}/]"
        info_debug_message "$MSG" "$FUNC" "$GEN_C_PRO_TOOL"
        mkdir "${PDIR}/"
        local ASHT=${project_set[AUTOGEN_SH]} ASHF="${PDIR}/autogen.sh"
        local ASHC=$(cat "${GEN_C_PRO_HOME}/conf/${ASHT}")
        MSG="Generating file [${ASHF}]"
        info_debug_message "$MSG" "$FUNC" "$GEN_C_PRO_TOOL"
        echo -e "${ASHC}" > "${ASHF}"
        local CT=${project_set[CONFIGURE_AC]} CF="${PDIR}/configure.ac" CL
        local CTF="${GEN_C_PRO_HOME}/conf/${CT}"
        MSG="Generating file [${CF}]"
        info_debug_message "$MSG" "$FUNC" "$GEN_C_PRO_TOOL"
        while read CL
        do
            eval echo "${CL}" >> ${CF}
        done < ${CTF}
        local PO="${PDIR}/po"
        MSG="Generating directory [${PO}/]"
        info_debug_message "$MSG" "$FUNC" "$GEN_C_PRO_TOOL"
        mkdir "${PO}/"
        local CHLOG="${PO}/ChangeLog" CLT=${project_set[CHANGELOG]} CLL
        local CLTF="${GEN_C_PRO_HOME}/conf/${CLT}" CHLOG2="${PDIR}/ChangeLog"
        MSG="Generating file [${CHLOG}]"
        info_debug_message "$MSG" "$FUNC" "$GEN_C_PRO_TOOL"
        while read CLL
        do
            eval echo "${CLL}" >> ${CHLOG}
            eval echo "${CLL}" >> ${CHLOG2}
        done < ${CLTF}
        local DESCRIPTION="# please keep this list sorted alphabetically"
        local LING="${PO}/LINGUAS"
        MSG="Generating file [${LING}]"
        info_debug_message "$MSG" "$FUNC" "$GEN_C_PRO_TOOL"
        echo -e "${DESCRIPTION}\n#" > ${LING}
        DESCRIPTION="# List of source files containing translatable strings."
        local POTF="${PO}/POTFILES.in"
        MSG="Generate file [${POTF}]"
        info_debug_message "$MSG" "$FUNC" "$GEN_C_PRO_TOOL"
        echo -e "${DESCRIPTION}\n\nsrc/main.c" > "${POTF}"
        local SRC="${PDIR}/src"
        MSG="Generating directory [${SRC}/]"
        info_debug_message "$MSG" "$FUNC" "$GEN_C_PRO_TOOL"
        mkdir "${SRC}/"
        local SCF="${SRC}/main.c" SCL SCT=${project_set[C_SOURCE]}
        local SCTF="${GEN_C_PRO_HOME}/conf/${SCT}"
        MSG="Generating file [${SCF}]"
        info_debug_message "$MSG" "$FUNC" "$GEN_C_PRO_TOOL"
        while read SCL
        do
            eval echo "${SCL}" >> ${SCF}
        done < ${SCTF}
        local CET=${project_set[C_EDIT]}
        local CETF=$(cat "${GEN_C_PRO_HOME}/conf/${CET}")
        local CEF="${SRC}/.editorconfig"
        MSG="Generating file [${CEF}]"
        info_debug_message "$MSG" "$FUNC" "$GEN_C_PRO_TOOL"
        echo -e "${CETF}" > "${CEF}"
        local MSF="${SRC}/Makefile.am" MST=${project_set[MAKEFILE_AMS]}
        local MSTF="${GEN_C_PRO_HOME}/conf/${MST}" MSL
        MSG="Generating file [${MSF}]"
        info_debug_message "$MSG" "$FUNC" "$GEN_C_PRO_TOOL"
        while read MSL
        do
            eval echo "${MSL}" >> ${MSF}
        done < ${MSTF}
        local MRF="${PDIR}/Makefile.am" MRL MRT=${project_set[MAKEFILE_AMR]}
        local MRTF="${GEN_C_PRO_HOME}/conf/${MRT}"
        MSG="Generating file [${MRF}]"
        info_debug_message "$MSG" "$FUNC" "$GEN_C_PRO_TOOL"
        while read MRL
        do
            eval echo "${MRL}" >> ${MRF}
        done < ${MRTF}
        local COT=${project_set[COPYING]} COF="${PDIR}/COPYING"
        local COC=$(cat "${GEN_C_PRO_HOME}/conf/${COT}")
        MSG="Generating file [${COF}]"
        info_debug_message "$MSG" "$FUNC" "$GEN_C_PRO_TOOL"
        echo -e "${COC}" > "${COF}"
        local AUT=${project_set[AUTHORS]} AUF="${PDIR}/AUTHORS" AUL
        local AUTF="${GEN_C_PRO_HOME}/conf/${AUT}"
        MSG="Generating file [${AUF}]"
        info_debug_message "$MSG" "$FUNC" "$GEN_C_PRO_TOOL"
        while read AUL
        do
            eval echo "${AUL}" >> ${AUF}
        done < ${AUTF}
        local NT=${project_set[NEWS]} NF="${PDIR}/NEWS" NL
        local FIRST_NEWS="Project created ${DATE}"
        local NTF="${GEN_C_PRO_HOME}/conf/${NT}"
        MSG="Generating file [${NF}]"
        info_debug_message "$MSG" "$FUNC" "$GEN_C_PRO_TOOL"
        while read NL
        do
            eval echo "${NL}" >> ${NF}
        done < ${NTF}
        local RT=${project_set[README]} RF="${PDIR}/README" RL
        local RMSG="${HASH} Readme section" RTF="${GEN_C_PRO_HOME}/conf/${RT}"
        MSG="Generating file [${RF}]"
        info_debug_message "$MSG" "$FUNC" "$GEN_C_PRO_TOOL"
        while read RL
        do
            eval echo "${RL}" >> ${RF}
        done < ${RTF}
        local USRID=${config_gen_c_pro_util[UID]}
        local GRPID=${config_gen_c_pro_util[GID]}
        eval "chown -R ${USRID}.${GRPID} ${PDIR}/"
        MSG="Set permission!"
        info_debug_message "$MSG" "$FUNC" "$GEN_C_PRO_TOOL"
        info_debug_message "$MSG" "$FUNC" "$GEN_C_PRO_TOOL"
        eval "chmod -R 755 ${PDIR}/"
        MSG="Generated C project ${PDIR}/"
        GEN_C_PRO_LOGGING[LOG_MSGE]=$MSG
        logging GEN_C_PRO_LOGGING
        info_debug_message_end "Done" "$FUNC" "$GEN_C_PRO_TOOL"
        TREE=$(which tree)
        check_tool "${TREE}"
        STATUS=$?
        if [ $STATUS -eq $SUCCESS ]; then
            eval "${TREE} -L 3 ${PDIR}/"
        fi
        exit 0
    fi
    usage GEN_C_PRO_USAGE
    exit 128
}

#
# @brief   Main entry point of script tool
# @param   Value required project name
# @exitval Script tool gen_c_pro exit with integer value
#            0   - tool finished with success operation
#            127 - run tool script as root user from cli
#            128 - missing argument(s) from cli
#            129 - failed to load tool script configuration from files
#            130 - failed to load configuration with project set
#            131 - project already exist
#
printf "\n%s\n%s\n\n" "${GEN_C_PRO_TOOL} ${GEN_C_PRO_VERSION}" "`date`"
check_root
STATUS=$?
if [ $STATUS -eq $SUCCESS ]; then
    __gen_c_pro $1
fi

exit 127
