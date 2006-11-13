From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-users] who is writing to my
	framebuffer?
Date: Mon, 13 Nov 2006 17:10:29 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611131701130.2366@pentafluge.infradead.org>
References: <bb9a78950610180759o7e923c90tc2e17c0dd72ed6a5@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
In-Reply-To: <bb9a78950610180759o7e923c90tc2e17c0dd72ed6a5@mail.gmail.com>
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
To: linux-fbdev-users@lists.sourceforge.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 18 Oct 2006, Nathan King wrote:

> Hey folks,
>
> I'm using a virtual framebuffer on some embedded hardware, and I'm trying to
> keep track of all changes to the framebuffer. I know when the three biggies,
> cfb_imageblit, cfb_fillrect, and cfb_copyarea write to it, but there's
> somebody else out there monkeying with it. These mystery writes happen
> during scrolling, which makes me think its somebody in fbcon. And I know its
> nothing from userspace, because this is happening during boot before we ever
> get to userspace. Is somebody in fbcon writing to my framebuffer behind my
> back?
>
> My mystery writes ARE cursor sized (8x16 pixels). I can't find any, but do
> any cursor functions operate directly on info->screen_base, without going
> through one of cfb*?
>
> What I'm seeing is that cfb_imageblit will receive a block of text from
> fbcon to draw at, say, (0,72), with a width of 64 pixels. Then the next
> block it receives is for (72,72). An eight pixel gap, and there should be
> some data between the two blocks. In fact if I look at the data after its
> finished with the line the data is somehow there. This happens at exactly
> the same locations every run.
>
> Much thanks,
> Nathan

Sorry about the late reply. You are right. The cursor code uses a timer to 
blink the cursor. Is this a embedded system? You really don't need fbcon 
in that case.


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
