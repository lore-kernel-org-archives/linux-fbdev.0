From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] VT locking
Date: Wed, 07 Jan 2004 08:44:00 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1073425440.773.10.camel@gaston>
References: <1073349182.9504.175.camel@gaston>
	 <Pine.GSO.4.58.0401061725250.5752@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Adz0C-0002od-Kl
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 13:44:40 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1Adz0C-0005hH-1j
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 13:44:40 -0800
In-Reply-To: <Pine.GSO.4.58.0401061725250.5752@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>, James Simmons <jsimmons@infradead.org>


>=20
> Looks like a nice opportunity to introduce an arch-specific printk() stub:
>=20
>     void *arch_printk(const char *args);
>=20
>     if (arch_printk)
> 	arch_printk(printk_buf);

Right... I admit I didn't even notice the printk_btext stuff leaked with
this patch, this is debug stuff that wasn't really supposed to get out
of my tree, oh well... I shouldn't do patches when I'm sick with +40=B0
fever...

Andrew, the only bits of the kernel/printk.c that are supposed to get
to your tree are related to is_console_locked() at this point. The
force_printk_to_btext is a debug tool that allow to route all printk's
to some early-boot output mecanism, though it would eventually be
acceptable upstream with Geert's idea of arch_printk...

Cheers,
Ben.




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=3D1278&alloc_id=3D3371&op=3Dclick
