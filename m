From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] fbdev: Fix usage of blank value passed
 to fb_blank
Date: Mon, 30 Jan 2006 06:19:35 +0800
Message-ID: <43DD3F77.5090306@gmail.com>
References: <20060127231314.GA28324@hansmi.ch> <20060127.204645.96477793.davem@davemloft.net> <43DB0839.6010703@gmail.com> <200601282106.21664.ioe-lkml@rameria.de> <43DC25EB.1040005@gmail.com> <20060129144228.GA22425@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F3Ktn-0004uw-EF
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 29 Jan 2006 14:19:55 -0800
Received: from xproxy.gmail.com ([66.249.82.192])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1F3Ktl-00086J-SY
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 29 Jan 2006 14:19:55 -0800
Received: by xproxy.gmail.com with SMTP id h29so594407wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 29 Jan 2006 14:19:53 -0800 (PST)
In-Reply-To: <20060129144228.GA22425@sci.fi>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, benh@kernel.crashing.org, linux-kernel@hansmi.ch

Ville Syrj=E4l=E4 wrote:
> On Sun, Jan 29, 2006 at 10:18:19AM +0800, Antonino A. Daplas wrote:
>> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
>> index d2dede6..5bed0fb 100644
>> --- a/drivers/video/fbmem.c
>> +++ b/drivers/video/fbmem.c
>> @@ -843,6 +843,19 @@ fb_blank(struct fb_info *info, int blank
>>  {=09
>>   	int ret =3D -EINVAL;
>> =20
>> +	/*
>> +	 * The framebuffer core supports 5 blanking levels (FB_BLANK), where=
as
>> +	 * VESA defined only 4.  The extra level, FB_BLANK_NORMAL, is a
>> +	 * console invention and is not related to power management.
>> +	 * Unfortunately, fb_blank callers, especially X, pass VESA constant=
s
>> +	 * leading to undefined behavior.
>=20
> Since when? X.Org uses numbers 0,2,3,4 which match the FB_BLANK=20
> constants not the VESA constants.
>=20

Hmm, you're correct... But I do remember that particular error before,
about FBIOBLANK returning -EINVAL. I think it may be coming from=20
this particular code


Bool
fbdevHWSaveScreen(ScreenPtr pScreen, int mode)
{
	ScrnInfoPtr pScrn =3D xf86Screens[pScreen->myNum];
	fbdevHWPtr fPtr =3D FBDEVHWPTR(pScrn);
	unsigned long unblank;

	TRACE_ENTER("HWSaveScreen");
	if (!pScrn->vtSema)
		return TRUE;

	unblank =3D xf86IsUnblank(mode);

	if (-1 =3D=3D ioctl(fPtr->fd, FBIOBLANK, (void *)(1-unblank))) {
		xf86DrvMsg(pScrn->scrnIndex, X_ERROR,
			   "FBIOBLANK: %s\n", strerror(errno));
		return FALSE;
	}

	return TRUE;
}

The FBIOBLANK ioctl call passes only 2 possible values, 0 and 1
(1-unblank).

Andrew,=20

I think you should drop this patch, Xorg/XFree86's fbdevhw DPMS support
does the correct thing. It's only the above that may be producing the
particular error as reported by David. I'm not sure how to fix that
(kernel or X side).


Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=3D=
121642
