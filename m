From: Stian Hartviksen <stian.hartviksen@itsopen.no>
Subject: Re: dual seat ...
Date: 12 May 2003 13:09:44 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1052737784.4391.8.camel@laptop-STIAN.kontor.itsopen.no>
References: <20030409180409.GA2551@iliana>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from ns2.kitrus.no ([212.4.54.162] helo=is1.itr.no)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19FBBp-0002lp-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 12 May 2003 04:09:53 -0700
Received: from is1.itr.no (localhost [127.0.0.1])
	by is1.itr.no (8.11.6/8.11.6) with ESMTP id h4CB9t830479
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 12 May 2003 13:09:55 +0200
In-Reply-To: <20030409180409.GA2551@iliana>
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
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi, Mr. Luther.

I'm sorry about the delay in the answer, but I've been away for some
time.

We have modified the solution from Freitas to work with FrameBuffers on
the 2.4 kernel. This solution can be found at:

http://www.itsopen.net/projects/x-hack/

This is a very nasty hack, but it works for us.

If you need any input or want to give us a hint on how to make the hack
somewhat prettier - please give us a note !


WBR Stian Hartviksen
ItsOpen AS



On Wed, 2003-04-09 at 20:04, Sven Luther wrote:
> Hello, ...
> 
> I am in urgent need of running the X server on gdb, which is really hard
> to do when one doesn't have a second computer at hand, as X starts in
> gdb all right, but doesn't enable one to switch back to the console to
> start the apps that cause the crash.
> 
> I have two ideas to solve this, the first one is to use a diskless
> notebook i have attached to a null modem and use a serial console, i
> would need a root disk containing minicom to do this, or a MS-dos
> minicom like app.
> 
> The other would be to run Linux as dual-seat, with my pci matrox
> millenium as the main head (with the keyboard attached to it) and
> running X on the second head, with just the mouse and a dummy keyboard.
> 
> Is this already possible with 2.5.x ? Any hint on how to best go about
> with this, and is the matroxfb finally ported to the new API, or do i
> need to apply a patch or something.
> 
> Thanks for your help.
> 
> Friendly,
> 
> Sven Luther
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
> for complex code. Debugging C/C++ programs can leave you feeling lost and 
> disoriented. TotalView can help you find your way. Available on major UNIX 
> and Linux platforms. Try it free. www.etnus.com
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
-- 
Stian Hartviksen <stian.hartviksen@itsopen.no>
ItsOpen



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
