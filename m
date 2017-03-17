From: kbuild test robot <lkp@intel.com>
Date: Fri, 17 Mar 2017 14:48:09 +0000
Subject: Re: [PATCH v8 3/3] backlight arcxcnn add support for ArcticSand devices
Message-Id: <201703172233.osJjGFrP%fengguang.wu@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1489607133-7870-3-git-send-email-olimpiu@arcticsand.com>
In-Reply-To: <1489607133-7870-3-git-send-email-olimpiu@arcticsand.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Olimpiu,

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.11-rc2 next-20170310]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Olimpiu-Dejeu/backlight-arcxcnn-add-arc-to-vendor-prefix/20170317-205447
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/video/backlight/arcxcnn_bl.c:183:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
