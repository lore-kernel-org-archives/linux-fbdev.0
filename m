From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: fbcon bug?
Date: Tue, 15 Nov 2005 08:51:13 +0800
Message-ID: <43793101.5050806@gmail.com>
References: <4377F564.6000704@comcast.net> <20051114191340.GA12139@sci.fi> <4378EF3E.8050609@gmail.com> <43792A1D.50208@comcast.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ebp2u-0006ek-Pt
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Nov 2005 16:51:36 -0800
Received: from xproxy.gmail.com ([66.249.82.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Ebp2t-0004Ke-J0
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Nov 2005 16:51:37 -0800
Received: by xproxy.gmail.com with SMTP id s6so1655453wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Nov 2005 16:51:34 -0800 (PST)
In-Reply-To: <43792A1D.50208@comcast.net>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Zack Smith <fbui@comcast.net>

Zack Smith wrote:
> Antonino A. Daplas wrote:
>> Once the console is in KD_GRPHICS mode, all access the to the
>> framebuffer are essentially stopped. 
> 
> What I'm seeing is that after a console switch to a KD_GRAPHICS console
> (call it A)
> from a KD_TEXT console (console B), B's cursor is seemingly undrawn in A.
> Basically, wherever the cursor was B, that's where you will see a black
> box drawn in A,
> and there is a delay in its being drawn.

Strange. If you can trace why this is happening, that will be helpful.

Note that vt.c also has it's own softcursor (it uses con->putc), which
sometimes run in parallel with fbcon's cursor so you might want to check
that also.

Tony


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
