From: Carl Vanderlip <carlv@codeaurora.org>
Date: Fri, 18 Mar 2011 21:47:26 +0000
Subject: [PATCH 00/20] video: msm: Adding Support for MDP3.1
Message-Id: <1300484846-26393-1-git-send-email-carlv@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

These patches continue to update the MSM display drivers to support newer MDP
versions and display modes (while also providing a base for future display
development).  The original source of these patches is one patch (squashing
together 22 other patches) on the Google Android kernel tree.

Brian Swetland (1):
  video: msm: Fix typo 'mpd'->'mdp'

Carl Vanderlip (19):
  video: msm: add spinlock to mdp_info struct
  video: msm: add locked_enable_mdp_irq function
  video: msm: Move clk to mdp_info struct
  video: msm: Setup framework for multiple output interfaces
  video: msm: Simplify mdp_blit function
  video: msm: Allow users to request a larger x and y virtual fb
  video: msm: Refactor mdp_regs
  video: msm: Split out MDP2.2 HW specific code.
  video: msm: Separate more MDP HW specific code
  video: msm: Add MDP FB DMA configuration
  video: msm: Add IRQ callback for MDP interface
  video: msm: Debugging for send_blit
  video: msm: Write IRQ mask to MDP registers
  video: msm: convert printk to pr_*
  video: msm: Set the EBI1 clock to 128MHz when performing blits
  video: msm: Prevent framebuffer glitch during initialization
  video: msm: Prevent DMA lockups when switching bit depths
  video: msm: Separate calculation of base and offset
  video: msm: Add support for MDP 3.1 (qsd8k)

 arch/arm/mach-msm/Kconfig                          |    8 +
 arch/arm/mach-msm/include/mach/msm_fb.h            |   11 +-
 drivers/video/msm/Makefile                         |    5 +-
 drivers/video/msm/mdp.c                            |  589 +++++++++++++-----
 drivers/video/msm/mdp_csc_table.h                  |  163 ++++--
 drivers/video/msm/mdp_hw.h                         |  205 +++++--
 drivers/video/msm/mdp_ppp.c                        |  639 ++++++++------------
 drivers/video/msm/mdp_ppp.h                        |   82 +++
 .../video/msm/{mdp_scale_tables.c => mdp_ppp22.c}  |  333 ++++++++++-
 drivers/video/msm/mdp_ppp31.c                      |  335 ++++++++++
 drivers/video/msm/mdp_scale_tables.h               |   38 --
 drivers/video/msm/msm_fb.c                         |   69 ++-
 12 files changed, 1775 insertions(+), 702 deletions(-)
 create mode 100644 drivers/video/msm/mdp_ppp.h
 rename drivers/video/msm/{mdp_scale_tables.c => mdp_ppp22.c} (69%)
 create mode 100644 drivers/video/msm/mdp_ppp31.c
 delete mode 100644 drivers/video/msm/mdp_scale_tables.h

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

