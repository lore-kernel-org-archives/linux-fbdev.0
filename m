From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [patch] (Preliminary) Geode framebuffer driver.
Date: Tue, 15 Feb 2005 21:38:24 +0800
Message-ID: <200502152138.24361.adaplas@hotpop.com>
References: <420C92F0.1090409@arcom.com> <200502120438.27671.adaplas@gawab.com> <4211D969.6070106@arcom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D12uc-0004Kz-FB
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Feb 2005 05:38:46 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D12ua-0006Wn-TE
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Feb 2005 05:38:46 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 7D9A9E17AE8
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Feb 2005 13:38:36 +0000 (UTC)
In-Reply-To: <4211D969.6070106@arcom.com>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, David Vrabel <dvrabel@arcom.com>

On Tuesday 15 February 2005 19:13, David Vrabel wrote:
> Antonino A. Daplas wrote:
> > On Friday 11 February 2005 19:11, David Vrabel wrote:
> >>Attached is a patch (against 2.6.10) for a framebuffer driver for the
> >>Geode family of processors.  It does not use AMD's horrible Durango API.
> >> It is, however, rather feature incomplete at the moment.
> >>
> >>	* Only Geode GX1 (with CS5530 companion chip) is supported.
> >>	* Tested resolutions: 640x480 to 1280x1024.
> >>	* Supported bit depths: 8 bit palette, 16 bit RGB 5-6-5.
> >>	* CRT output only.
> >>	* No accelerated features.
> >>	* Compression is not enabled.
> >>
> >>Could this patch be considered for inclusion, please?
> >
> > Yes.
> >
> > However, I would prefer that instead of:
> >
> > struct geodefb_info {
> >     	struct fb_info fb;
> > 	...
> >
> > use struct fb_info.par for all driver private data and use
> > framebuffer_release()/framebuffer_alloc() to de/allocate the fb_info
> > structure.
>
> Done this now.  An updated patch is attached.
>
> This also includes a number of other changes:
>
>   - now works when built into the kernel
>   - flat panel support (panel=<x>x<y> option). (Only one 640x480 panel
>     has been tested though.)
>   - blank function for display blanking/powersaving.
>   - crt=<n> option to enable/disable the CRT output.
>
> David Vrabel

A few minor comments:

+        /* Clear the frame buffer of garbage. */
+        memset(info->screen_base, 0, info->fix.smem_len);

Is the above really necessary?  And if it is, memset_io is preferred.

+	info->screen_base = (unsigned char *)ioremap(info->fix.smem_start, info->fix.smem_len);

You also do not need the (unsigned char *) part. (sparse will complain.)

No need to resend the patch, just let me know what changes you want, if any.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
