From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 7/8] [RESEND] fbdev: fbcon: Console
 unregistration from unregister_framebuffer
Date: Thu, 31 May 2007 18:57:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0705311856020.1591@pademelon.sonytel.be>
References: <465ECDBE.6010700@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Htny0-0001SX-8q for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 09:57:45 -0700
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Htnxy-0002q0-41
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 09:57:39 -0700
In-Reply-To: <465ECDBE.6010700@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Jesse Barnes <jesse.barnes@intel.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

On Thu, 31 May 2007, Antonino A. Daplas wrote:
> This allows for proper console unregistration via the VT layer, and updates
> the FB layer to use it.  This makes debugging new console drivers much easier,
> since you can properly clean them up before unloading.

> Geert,
> 
> Is this patch suitable for your needs?

Yes, seems to work fine! Thanks a lot!

Unfortunately I had to hunt for quite a few other patches before it applied to
current linux.git ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
