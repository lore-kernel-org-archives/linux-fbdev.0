From: Antonino Daplas <adaplas@pol.net>
Subject: Re: fb_imageblit semantic
Date: 17 Mar 2003 21:01:58 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047906068.2599.51.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0303171312590.17453-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18uuJ3-0001Ix-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Mar 2003 05:05:33 -0800
In-Reply-To: <Pine.GSO.4.21.0303171312590.17453-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2003-03-17 at 20:18, Geert Uytterhoeven wrote:
> On 17 Mar 2003, Antonino Daplas wrote:
> > On Mon, 2003-03-17 at 18:40, Petr Vandrovec wrote:
> > > On 17 Mar 03 at 11:31, Geert Uytterhoeven wrote:
> > > > On 17 Mar 2003, Antonino Daplas wrote:
> > > > > As Geert said, it's not just trivial, but logical to split fb_imageblit
> > > > > into two.
> > > > 
> > > > So, are we gonna split it? This will also make hardware acceleration support
> > > > more clean. E.g. most sbus drivers do color expansion in hardware, and fall
> > > > back to cfb_imageblit() for the logo.
> > 
> > It's up to James, though I vote for it.  And I don't think any driver
> > has accelerated versions of fb_imageblit for the logo, since any
> > performance gained is probably minimal and it will involve too much work
> > for something that's going to be done only once.
> 
> Wait until someone wants 256-color fonts ;-)

When we do get that to that point, the entire interface will be
revamped.  Imagine passing 128 bytes to draw a single character.  This
is where Tile Blitting comes in.

Tony



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
