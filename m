From: Mythri P K <mythripk@ti.com>
Date: Wed, 22 Jun 2011 11:55:08 +0000
Subject: [PATCH 0/8] HDMI: Split hdmi.c to seperate HDMI IP dependant code from DSS.
Message-Id: <1308742996-19230-1-git-send-email-mythripk@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

HDMI IP block is common between TI OMAP4 Procerssor and Netra processor although
the Display subsytem is different. Thus to reuse the code between these two
processors , HDMI IP dependant code is seperated out from hdmi.c and moved to
new library file hdmi_ti_4xxx_ip.c which now resides in /drivers/video a more
generic location out of omap2/dss folder.

This patch series does the split and also renames hdmi_omap4_panel.c to
hdmi_panel.c as that file has nothing specific to OMAP4 and can be reused for
other OMAP family of processors as well.

This is based on Tomi's DSS pmruntime-v2 branch:
git://gitorious.org/linux-omap-dss2/linux.git

Tree with the patches for verification is available in
http://gitorious.org/~mythripk/linux-omap-dss2/mythripk-linux-lo-dss2/commits/hdmi_pmrumtime

Mythri P K (8):
  OMAP4: DSS: HDMI: HDMI clean up to pass base_address     dynamically
    to IP dependant functions of HDMI
  OMAP4 : DSS : HDMI : Move the EDID portion from HDMI IP header
  OMAP4: DSS: HDMI: Use specific HDMI timings structure instead     of
    OMAP DSS timings
  OMAP4: DSS: HDMI: Move the common header file definition     to
    Include/video
  OMAP4: DSS2: HDMI: Split the HDMI driver to DSS and IP specific
    portion.
  OMAP4: DSS: HDMI: Rename the functions in HDMI IP library to IP
    specific name
  HDMI: Move HDMI IP Library from OMAP DSS to common  Video     
    directory for IP present in TI OMAP4, TI81xx,  TI38xx     
    Processor
  OMAP4: DSS: Rename hdmi_omap4_panel.c to hdmi_panel.c

 drivers/video/Kconfig                              |    7 +
 drivers/video/Makefile                             |    1 +
 drivers/video/hdmi_ti_4xxx_ip.c                    |  803 +++++++++++++++++
 drivers/video/hdmi_ti_4xxx_ip.h                    |  587 +++++++++++++
 drivers/video/omap2/dss/Kconfig                    |    1 +
 drivers/video/omap2/dss/Makefile                   |    2 +-
 drivers/video/omap2/dss/dss.h                      |   10 -
 drivers/video/omap2/dss/hdmi.c                     |  919 ++++----------------
 drivers/video/omap2/dss/hdmi.h                     |  631 --------------
 .../omap2/dss/{hdmi_omap4_panel.c => hdmi_panel.c} |    2 +-
 include/video/hdmi_ti_4xxx_ip.h                    |   94 ++
 11 files changed, 1641 insertions(+), 1416 deletions(-)
 create mode 100644 drivers/video/hdmi_ti_4xxx_ip.c
 create mode 100644 drivers/video/hdmi_ti_4xxx_ip.h
 delete mode 100644 drivers/video/omap2/dss/hdmi.h
 rename drivers/video/omap2/dss/{hdmi_omap4_panel.c => hdmi_panel.c} (99%)
 create mode 100644 include/video/hdmi_ti_4xxx_ip.h

-- 
1.7.5.4

