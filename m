From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeonfb on pegasos powerpc motherboard
	and X endianess problem
Date: 05 Jun 2003 14:27:23 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1054816042.1000.2.camel@gaston>
References: <20030604145423.GA22876@iliana> <1054799986.701.20.camel@gaston>
	 <20030605081925.GA14714@iliana> <1054813350.701.38.camel@gaston>
	 <20030605115821.GA17301@iliana>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from griffon.mipsys.com ([217.167.51.129] helo=gaston)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19NtqW-0004gg-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 05 Jun 2003 05:27:56 -0700
In-Reply-To: <20030605115821.GA17301@iliana>
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
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-06-05 at 13:58, Sven Luther wrote:
> On Thu, Jun 05, 2003 at 01:42:30PM +0200, Benjamin Herrenschmidt wrote:
> > On Thu, 2003-06-05 at 10:19, Sven Luther wrote:
> > 
> > > Err, is that the same devel tree as the one in linuxppc_2_4_devel ?
> > 
> > No, it's linuxppc_2_4_benh bk, though you can use rsync to extract
> > just radeonfb from rsync.penguinppc.org::benh-devel.
> 
> Mmm, i think i am just a bit lost with all the ppc kernel trees ...
> Which one should i work on.

Yup, 2.4 is a mess ... For a new platform like that, I suggest 
working on linuxppc_2_4 or Marcelo tree directly

> .../...
>
> I don't know about the radeon driver exactly but the glint driver i did
> work on did a mode setup when comming from the VT switch, after having
> saved the registers it touches for the consoles benefit. It then
> proceeded to reinitialize the accel pipeline, complete with a sync and
> all. I guess newer hardware have easier way to do this, and this doesn't
> speak about the DRI case, but probably all the X driver do it such. When
> switching back, they restore the registers they have touched, more
> probably only the mode setting registers, and don't care about the accel
> regs, since text mode don't touch them.

Which is the problem ;) radeonfb do use the accel engine for text
rendering, which is why things aren't pretty when coming from X
(actually, I noticed X tends to fuckup the accel engine when quit
even while it's not the frontmost console, so there's probably also
a bug in X)


> Ok, so it must be another kind of problems, but then, my matrox board,
> which Geert (or someone else) said did run on his chrp board, did not
> work well for me.

Could be a problem with how the firmware did/did not initialize it

Ben.



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
