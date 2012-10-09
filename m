From: Ajay Kumar <ajaykumar.rs@samsung.com>
Date: Tue, 09 Oct 2012 14:04:23 +0000
Subject: [PATCH V4 0/2] video: exynos_dp: Add device tree support to DP driver
Message-Id: <1349824101-32574-1-git-send-email-ajaykumar.rs@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, jg1.han@samsung.com, devicetree-discuss@lists.ozlabs.org
Cc: FlorianSchandinat@gmx.de, sylvester.nawrocki@gmail.com, tomasz.figa@gmail.com, thomas.ab@samsung.com

Changes from V3:
	--Fix typos in the documentation file "exynos_dp.txt".
	--Use variable name enable_mask instead of enable_bit.
	--Use property name samsung,dp_phy instead of dp-phy.

To linux-fbdev:
  [PATCH V4 1/2] video: exynos_dp: Add device tree support to DP driver

To devicetree discussion list:
  [PATCH V4 2/2] video: exynos_dp: device tree documentation

 .../devicetree/bindings/video/exynos_dp.txt        |   81 ++++++++++
 drivers/video/exynos/exynos_dp_core.c              |  168 ++++++++++++++++++--
 drivers/video/exynos/exynos_dp_core.h              |    2 +
 3 files changed, 239 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/exynos_dp.txt

