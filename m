From: Sekhar Nori <nsekhar@ti.com>
Date: Mon, 08 Oct 2012 12:52:12 +0000
Subject: Re: [PATCH 1/2] da8xx-fb: move panel information from driver to platform file
Message-Id: <5072C9AC.70901@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1349445084-9857-2-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1349445084-9857-2-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Prakash,

On 10/5/2012 7:21 PM, Manjunathappa, Prakash wrote:
> Moving panel information from driver to platform file, patch also made
> compliant to fb_videomode data.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>

Why do you have to do this? Just moving panel data from driver to
platform code doesn't seem to buy anything.

If you are passed DT data, then use it else continue the existing
platform data method? Once all the boards using this driver are
converted to DT, then all the panel information can be removed from
driver. That will save code.

This patch looks like needless churn.

Thanks,
Sekhar
