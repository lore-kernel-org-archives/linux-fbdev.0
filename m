From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH]: EDID parser
Date: 03 Apr 2003 17:15:32 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1049386531.11747.32.camel@dhcp22.swansea.linux.org.uk>
References: <1049383273.11742.0.camel@dhcp22.swansea.linux.org.uk>
	 <Pine.GSO.4.21.0304031831030.23642-100000@vervain.sonytel.be>
	 <20030403171009.GC1092@iliana>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86] helo=lxorguk.ukuu.org.uk)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1918I0-0001o5-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 03 Apr 2003 09:14:12 -0800
In-Reply-To: <20030403171009.GC1092@iliana>
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
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Iau, 2003-04-03 at 18:10, Sven Luther wrote:
> It has two outputs, where i can hook either a DVI or a VGA monitor. Each
> of these video outputs correspond to a viewport, and there is hardware
> which will let you set the output timings and the dot clock. You also
> have to configure which part of the framebuffer you are reading, and
> eventually setup a scaller to scale the pixels you read to the correct
> output buffer. You also have for each head a DDC/I2C bus you can use to
> speak with the monitor.

Very common except lower end stuff generally has a single frame buffer
that both show and cannot be split or scanned by multiple outputs at
different rates.



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
