From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 06 Mar 2003 18:30:08 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046946554.1209.78.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0303061113520.28248-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qscM-00050T-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Mar 2003 02:28:50 -0800
In-Reply-To: <Pine.GSO.4.21.0303061113520.28248-100000@vervain.sonytel.be>
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
Cc: Thomas Winischhofer <thomas@winischhofer.net>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-03-06 at 18:14, Geert Uytterhoeven wrote:
> On 6 Mar 2003, Antonino Daplas wrote:
> > On Thu, 2003-03-06 at 17:12, Geert Uytterhoeven wrote:
> > > What if fbcon implements a text console _on top of_ fbdev? I.e. it uses the
> > > current resolution?
> > > 
> > > If you use stty to change the number of cols/rows, or change the font, or use
> > > fbset, your text console may end up being smaller or larger than the real
> > > screen size, in which case margins are cleared, or columns/lines are lost.
> > > (Optionally, we can center the text console if it's smaller than the real
> > >  screen size.)
> > > 
> > 
> > Which is basically what stty does for the standard console (except that
> > lines are not lost, but wrapped, and margins are not cleared).
> > 
> > So, we need to reimplement the clipping code.
> 
> In fbcon, I hope?
> 

Yes, it's easier to do this in fbcon.

Tony



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
