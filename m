From: kbuild test robot <lkp@intel.com>
Date: Fri, 22 Dec 2017 22:23:26 +0000
Subject: Re: [PATCH] backlight: otm3225a: add support for ORISE OTM3225A LCD SoC
Message-Id: <201712230655.iSiAPzhF%fengguang.wu@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1513792670-4114-1-git-send-email-fb@ltec.ch>
In-Reply-To: <1513792670-4114-1-git-send-email-fb@ltec.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Felix,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on backlight/for-backlight-next]
[also build test WARNING on v4.15-rc4 next-20171222]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Felix-Brack/backlight-otm3225a-add-support-for-ORISE-OTM3225A-LCD-SoC/20171223-042842
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git for-backlight-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)


Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
