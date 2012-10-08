From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Mon, 08 Oct 2012 16:33:39 +0000
Subject: RE: [PATCH 1/2] da8xx-fb: move panel information from driver to platform file
Message-Id: <A73F36158E33644199EB82C5EC81C7BC3E9C943A@DBDE01.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1349445084-9857-2-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1349445084-9857-2-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Sekhar,

On Mon, Oct 08, 2012 at 18:10:12, Nori, Sekhar wrote:
> Hi Prakash,
> 
> On 10/5/2012 7:21 PM, Manjunathappa, Prakash wrote:
> > Moving panel information from driver to platform file, patch also made
> > compliant to fb_videomode data.
> > 
> > Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> 
> Why do you have to do this? Just moving panel data from driver to
> platform code doesn't seem to buy anything.
> 
> If you are passed DT data, then use it else continue the existing
> platform data method? Once all the boards using this driver are
> converted to DT, then all the panel information can be removed from
> driver. That will save code.
> 

Because of following reasons I moved it out of driver
1)This patch also converts panel information compliant to fb_videomode.
Patch "of: add display helper"[1] under review expects panel data in fb_videomode format.
2)I felt difficult and unclean to have driver supporting both panel data from driver and panel data from DT.
3)This effort will also ease adding DT support of this driver.

[1]http://marc.info/?l=linux-fbdev&m4937359209227&w=2

Thanks,
Prakash

> This patch looks like needless churn.
> 
> Thanks,
> Sekhar
> 

