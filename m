From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: Re: FBdev updates.
Date: Sun, 9 Mar 2003 22:29:03 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030309212903.GC16578@vana.vc.cvut.cz>
References: <Pine.LNX.4.44.0302200108090.20350-100000@phoenix.infradead.org> <20030220150201.GD13507@codemonkey.org.uk> <20030220182941.GK14445@vana.vc.cvut.cz> <1045787031.2051.9.camel@localhost.localdomain> <20030303203500.GA2916@vana.vc.cvut.cz> <20030304212906.GA1115@middle.of.nowhere>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from vana.vc.cvut.cz ([147.32.240.58] ident=root)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18s8M4-0000Ls-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 09 Mar 2003 13:29:12 -0800
Content-Disposition: inline
In-Reply-To: <20030304212906.GA1115@middle.of.nowhere>
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
To: jsimmons@infradead.org
Cc: Antonino Daplas <adaplas@pol.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi James,
  I tried to use fb_cursor and I have quite a lot problems with
it:
(1) it uses global variables for storing last cursor value -
    - but there is no global hardware, so after switching from
    one fbdev to another you can have cursor with wrong shape,
    wrong color and so on...
(2) callback from timer for cursor blinking may set almost any
    FB_CUR_* bits. But in this case fb_cursor callback may be
    called from interrupt context, while accelerator is busy
    and so on... Did I miss some synchronization? Best for me
    would be disabling blinking code in fbcon completely:
    in VGA mode cursor blinks automatically, and in graphics mode
    more lightweight only 'flash' callback is more appropriate
    for me. But then there is problem with
(3) cursor_undrawn... I have no idea how is this supposed to work
    if fbdev provides hardware cursor... And HZ/50 delay after
    putcs makes orientation on screen very complicated, as there
    is no cursor while new characters are appearing on screen.
    
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
