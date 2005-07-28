From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Move softcursor out of fbdev to fbcon
Date: Wed, 27 Jul 2005 20:42:47 -0400
Message-ID: <9e473391050727174222690eea@mail.gmail.com>
References: <42E73C6E.1090205@gmail.com>
	 <9e473391050727073269e33a44@mail.gmail.com>
	 <42E7D77F.6020005@gmail.com>
	 <Pine.LNX.4.56.0507272313530.4063@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DxwUB-0000x7-3R
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 17:42:55 -0700
Received: from wproxy.gmail.com ([64.233.184.197])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DxwU9-0001xL-Vo
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 17:42:55 -0700
Received: by wproxy.gmail.com with SMTP id 36so293297wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 27 Jul 2005 17:42:47 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.56.0507272313530.4063@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 7/27/05, James Simmons <jsimmons@infradead.org> wrote:
> > > It has always bugged me that there was no real interface between
> > > fbconsole and fbdev. For example I tried to write a wrapper for DRM s=
o
> > > that fbconsole could use DRM for accelerated console. But fbconsole i=
s
> > > so tied into the fbdev data structures writing the wrapper required m=
e
> > > to build most of an fbdev driver. I shouldn't need to do that,
> > > fbconsole should not be poking at fb_info, it should use an API for
> > > making changes.
> >
> > Yes. I think I'm planning to do that in small steps. I'm thinking first=
 of
> > separating all fbcon-specific fields and place them in another structur=
e,
> > ie, fbcon_info.  This struct will be registered separately from fb_info=
,
> > and only if fbcon is enabled.
>=20
> Thats why its called the framebuffer console. It used the framebuffer api=
.
> Making a API between fbconsole and fbdev would be more bloat and whould
> have a performance it. The idea is to go as fast as possible.

A few extra instructions implementing an API won't make much of a
difference. We can only update the screen 70 times a second or so.
Wouldn't it be better to make an API than have me copy fbconsole,
rename it driconsole and then edit it to make it work? An API makes
the code more maintainable and reusable.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
