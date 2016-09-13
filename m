From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 13 Sep 2016 13:37:19 +0000
Subject: Re: [powerpc] offb: red / blue color inversion
Message-Id: <CA+7wUszOrXGRTEwi6JKo0Ozsr-OKf-Nq0fodzR+RG-jd0fuRhg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+7wUsw+LHgCz6SDHxrbPiwrpN53WB7+KxaAgnVYdwrp4OyVQQ@mail.gmail.com>
In-Reply-To: <CA+7wUsw+LHgCz6SDHxrbPiwrpN53WB7+KxaAgnVYdwrp4OyVQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Geert,

On Fri, Jun 17, 2016 at 9:11 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Mathieu,
>
> On Thu, Jun 9, 2016 at 2:25 PM, Mathieu Malaterre <malat@debian.org> wrote:
>> I am trying to fix an issue with color inversion in the current offb.c
>> implementation. I am using a Mac Mini G4 (PPC) with:
>>
>> [    0.844144] fb0: Open Firmware frame buffer device on
>> /pci@f0000000/ATY,RockHopper2Parent@10/ATY,RockHopper2_A@0
>>
>> reported as [*]. I have tried looking at the upstream code source, and
>> it appears that my configuration falls into the 'cmap_simple'. But
>> other than that I failed to understand what could be wrong (palette
>> would be setup backward).
>
> The palette code for cmap_simple writes the color components in the
> order RGB, while your card seems to need BGR.
>
> Hence either the cmap_addr/cmap_data registers are wrong, or
> you have to add a cmap_inverted type that writes in the BGR order.
>
> For both cases, you have to add a check to offb_init_palette_hacks() in
> drivers/video/fbdev/offb.c.

Well I tried a (very naive) patch as follow:

--- a/drivers/video/fbdev/offb.c 2016-09-13 15:33:41.043843352 +0200
+++ b/drivers/video/fbdev/offb.c 2016-08-20 18:11:18.000000000 +0200
@@ -133,9 +133,9 @@
  switch (par->cmap_type) {
  case cmap_simple:
  writeb(regno, par->cmap_adr);
- writeb(blue, par->cmap_data);
- writeb(green, par->cmap_data);
  writeb(red, par->cmap_data);
+ writeb(green, par->cmap_data);
+ writeb(blue, par->cmap_data);
  break;
  case cmap_M3A:
  /* Clear PALETTE_ACCESS_CNTL in DAC_CNTL */

However it does not seems to fix the Red / Blue color inversion I am seeing.

Could you please be a little more verbose in the way I need to reorder
color component from RGB to BGR ?

Thanks again
-M
