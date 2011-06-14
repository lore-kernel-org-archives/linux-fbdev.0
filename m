From: Manuel Lauss <manuel.lauss@googlemail.com>
Date: Tue, 14 Jun 2011 08:23:42 +0000
Subject: Re: [PATCH] au1200fb: fix hardcoded IRQ
Message-Id: <BANLkTimkkBWdc2mWQtAZKWwe+4f7g5rTnQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307898929-12365-1-git-send-email-manuel.lauss@googlemail.com>
In-Reply-To: <1307898929-12365-1-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Paul,

On Tue, Jun 14, 2011 at 9:10 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Sun, Jun 12, 2011 at 07:15:29PM +0200, Manuel Lauss wrote:
>> Use the IRQ provided by platform resource information.
>> Required for Au1300 support.
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
>> ---
>> applies on top of the other 3 au1200fb patches sent earlier.
>>
>> =A0drivers/video/au1200fb.c | =A0 12 +++++++-----
>> =A01 files changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
>> index e018373..e6d3478 100644
>> --- a/drivers/video/au1200fb.c
>> +++ b/drivers/video/au1200fb.c
>> @@ -1631,7 +1631,7 @@ static int __devinit au1200fb_drv_probe(struct pla=
tform_device *dev)
>> =A0 =A0 =A0 struct au1200fb_device *fbdev;
>> =A0 =A0 =A0 struct fb_info *fbi =3D NULL;
>> =A0 =A0 =A0 unsigned long page;
>> - =A0 =A0 int bpp, plane, ret;
>> + =A0 =A0 int bpp, plane, ret, irq;
>>
>> =A0 =A0 =A0 /* shut gcc up */
>> =A0 =A0 =A0 ret =3D 0;
>> @@ -1707,10 +1707,12 @@ static int __devinit au1200fb_drv_probe(struct p=
latform_device *dev)
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 /* Now hook interrupt too */
>> - =A0 =A0 if ((ret =3D request_irq(AU1200_LCD_INT, au1200fb_handle_irq,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_DISABLED | IRQF_SHARE=
D, "lcd", (void *)dev)) < 0) {
>> + =A0 =A0 irq =3D platform_get_irq(dev, 0);
>> + =A0 =A0 ret =3D request_irq(irq, au1200fb_handle_irq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_DISABLED | IRQF_SHARE=
D, "lcd", (void *)dev);
>> + =A0 =A0 if (ret) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 print_err("fail to request interrupt line %d=
 (err: %d)",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AU1200_LCD_INT, ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq, ret);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed;
>> =A0 =A0 =A0 }
>>
> A minor nit, but if you're passing along IRQ information via the platform
> data already you could take that a step further and also fetch the IRQ
> flags. This would at least allow you to avoid an unconditional
> IRQF_SHARED.

That IRQF_SHARED is required because the out-of-tree mpeg decoder
driver attaches to this irq as well.  I'll incorporate it in the rewrite th=
ough.

Thanks!
        Manuel Lauss
