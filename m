From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: [PATCH]: EDID parser
Date: Thu, 3 Apr 2003 19:18:20 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030403171820.GE1092@iliana>
References: <1049383273.11742.0.camel@dhcp22.swansea.linux.org.uk> <Pine.GSO.4.21.0304031831030.23642-100000@vervain.sonytel.be> <20030403171009.GC1092@iliana> <1049386531.11747.32.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp4.wanadoo.fr ([193.252.22.28] helo=mwinf0301.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 1918MB-0002el-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 03 Apr 2003 09:18:31 -0800
Content-Disposition: inline
In-Reply-To: <1049386531.11747.32.camel@dhcp22.swansea.linux.org.uk>
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
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, Geert Uytterhoeven <geert@linux-m68k.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Apr 03, 2003 at 05:15:32PM +0100, Alan Cox wrote:
> On Iau, 2003-04-03 at 18:10, Sven Luther wrote:
> > It has two outputs, where i can hook either a DVI or a VGA monitor. Each
> > of these video outputs correspond to a viewport, and there is hardware
> > which will let you set the output timings and the dot clock. You also
> > have to configure which part of the framebuffer you are reading, and
> > eventually setup a scaller to scale the pixels you read to the correct
> > output buffer. You also have for each head a DDC/I2C bus you can use to
> > speak with the monitor.
> 
> Very common except lower end stuff generally has a single frame buffer
> that both show and cannot be split or scanned by multiple outputs at
> different rates.

So, using the terminology of Petr's graph, you have only one CRTC, with
two possible outputs, or maybe you have two CRTC but which needs to be
synchronized between them ?

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
