From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Re: [PATCH 1/9] viafb: VIA Frame Buffer Device
	Driver - Resend
Date: Thu, 8 May 2008 10:15:08 +0200
Message-ID: <20080508081508.GD11121@localhost.localdomain>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F67745@exchtp03.taipei.via.com.tw>
	<20080507184333.7d0f1bf4.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ju1Hp-0004nO-3z for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 May 2008 01:15:33 -0700
Received: from smtp1.kolej.mff.cuni.cz ([78.128.192.10])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ju1HZ-0000Rk-DT
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 May 2008 01:15:17 -0700
Content-Disposition: inline
In-Reply-To: <20080507184333.7d0f1bf4.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: JosephChan@via.com.tw, geert@linux-m68k.org, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Wed, May 07, 2008 at 06:43:33PM +0200, Krzysztof Helt wrote:
> PS. I assume that your driver will replace the existing vt8623fb (CLE266?) driver when ready. Am I right?

These drivers are hardly comparable. vt8623fb supports CLE266 with VGA output only,
but allows arbitrary resolutions and pixclocks, high-res text mode and
(partially) suspend/resume. viafb implements fixed resolutions only and
have no text mode and no suspend/resume support (according to my quick
look on it).

-- 
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
