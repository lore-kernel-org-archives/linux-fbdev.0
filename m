From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: Re: rotation.
Date: Wed, 8 Jan 2003 11:48:17 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030108104817.GA10165@iliana>
References: <Pine.LNX.4.44.0301072240530.17129-100000@phoenix.infradead.org> <Pine.GSO.4.21.0301081120540.21171-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233] helo=mel-rto3.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18WDpC-0004Tu-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 08 Jan 2003 02:52:42 -0800
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0301081120540.21171-100000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Jan 08, 2003 at 11:24:22AM +0100, Geert Uytterhoeven wrote:
> On Tue, 7 Jan 2003, James Simmons wrote:
> > I'm about to implement rotation which is needed for devices like the ipaq. 
> > The question is do we flip the xres and yres values depending on the 
> > rotation or do we just alter the data that will be drawn to make the 
> > screen appear to rotate. How does hardware rotate view the x and y axis?
> > Are they rotated or does just the data get rotated? 
> 
> Where are you going to implement the rotation? At the fbcon or fbdev level?
> 
> Fbcon has the advantage that it'll work for all frame buffer devices.

But you could also provide driver hooks for the chips which have such a
rotation feature included (don't know if such exist, but i suppose they
do, or may in the future).

So, we also support fbcon for not left to righ locales ?

Friendly,

Sven Luther


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
