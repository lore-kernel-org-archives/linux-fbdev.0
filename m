From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 15 Nov 2012 15:32:06 +0000
Subject: video: pull request for branch "cfa-10049-3.7-oled-driver"
Message-Id: <1352993527-9113-1-git-send-email-maxime.ripard@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Florian,

Since these patches have been around for a few months without any comment,
please pull the following branch.

Thanks,
Maxime

The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:

  Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)

are available in the git repository at:

  https://github.com/crystalfontz/cfa_10036_kernel.git cfa-10049-3.7-oled-driver

for you to fetch changes up to 353b74485bd80950b4beea1497fa234d3277e4e8:

  video: Add support for the Solomon SSD1307 OLED Controller (2012-10-22 12:35:02 +0200)

----------------------------------------------------------------
Maxime Ripard (1):
      video: Add support for the Solomon SSD1307 OLED Controller

 .../devicetree/bindings/video/ssd1307fb.txt        |   24 ++
 drivers/video/Kconfig                              |   13 +
 drivers/video/Makefile                             |    1 +
 drivers/video/ssd1307fb.c                          |  407 ++++++++++++++++++++
 4 files changed, 445 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/ssd1307fb.txt
 create mode 100644 drivers/video/ssd1307fb.c
