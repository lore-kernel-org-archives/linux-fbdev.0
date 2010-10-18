From: Sangbeom Kim <sbkim73@samsung.com>
Date: Mon, 18 Oct 2010 12:55:24 +0000
Subject: [PATCH 0/4] ARM: S5PV310: Add support FIMD
Message-Id: <1287406528-15324-1-git-send-email-sbkim73@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch adds support FIMD(Fully Interactive Mobile Display) on S5PV310 and S5PC210.
The 3rd patch is update s3c-fb for it and others are for platform data.

[PATCH 1/4] ARM: S5PV310: Add FIMD resource definition
[PATCH 2/4] ARM: S5PV310: Add platform device and helper functions for FIMD
[PATCH 3/4] s3c-fb: Add support S5PV310 FIMD
[PATCH 4/4] ARM: S5PV310: Add platform data for S5PV310 FIMD and LTE480WV platform-lcd
