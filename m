From: Andrew Morton <akpm@osdl.org>
Subject: Re: Fw: [Bugme-new] [Bug 5441] New: SVGATextMode problem on
 2.6.14-rc4
Date: Fri, 14 Oct 2005 16:22:46 -0700
Message-ID: <20051014162246.6ba852a3.akpm@osdl.org>
References: <20051014103144.16a7bb65.akpm@osdl.org>
	<20051014231408.GK5100@bouh.residence.ens-lyon.fr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EQYt6-0006ig-RY
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Oct 2005 16:22:56 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1EQYt6-00032L-GA
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Oct 2005 16:22:56 -0700
In-Reply-To: <20051014231408.GK5100@bouh.residence.ens-lyon.fr>
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
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Krzysztof  Oledzki <olel@ans.pl>
Cc: linux-fbdev-devel@lists.sourceforge.net, wa1ter@myrealbox.com, "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@kernel-bugs.osdl.org>

Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:
>
> Hum, I didn't know about messy programs like svgatextmode... Couldn't
> this be integrated in some linux/drivers/video/console/svgacon.c ?... So
> because of the existence of the svgatextmode program, the kernel is not
> supposed to touch to CRT_OVERFLOW/SYNC_END/DISP/DISP_END/OFFSET ?
> 
> Disabling the check in vgacon_resize() might help indeed, but I'm really
> not sure whether it will work for any chipset: in my patch, CRT
> registers are set at each console switch, since stty rows/cols apply to
> consoles separately...
> 
> The attached solution is to keep the test, but if it fails, we assume
> that the caller knows what it does (i.e. it is svgatextmode) and then
> disable any further call to vgacon_doresize. Svgatextmode is usually
> used to _expand_ the display, not to shrink it. And it is harmless in
> the case of a too big stty rows/cols: the display will just be cropped.
> I tested it on my laptop, and it works fine with svgatextmode.
> 
> A better solution would be that svgatextmode explicitely tells the
> kernel not to care about video timing, but for this an interface needs
> be defined and svgatextmode be patched.

hm, you removed bugzilla from the Cc.  Please don't do that.  I've restored
it, and I've cc'ed the reporter (Krzysztof) directly.

Krzysztof, could you please test Samuel's fix (which I forwarded) and let
us know?

Thanks.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
