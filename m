From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] Framebuffer mode required for PowerBook Titanium
Date: Sun, 06 Nov 2005 08:38:52 +0800
Message-ID: <436D509C.8050306@gmail.com>
References: <20051105234938.GA18608@hansmi.ch> <436D4A36.70606@gmail.com> <20051106003019.GA19508@hansmi.ch>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EYYYo-0007JS-Nm
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Nov 2005 16:39:02 -0800
Received: from xproxy.gmail.com ([66.249.82.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EYYYn-0005pS-Iw
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Nov 2005 16:39:02 -0800
Received: by xproxy.gmail.com with SMTP id h29so146834wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 05 Nov 2005 16:39:00 -0800 (PST)
In-Reply-To: <20051106003019.GA19508@hansmi.ch>
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
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Michael Hanselmann wrote:
>> Does booting with video=xxxfb:1152x768M@60 work?  If it does, I would prefer
>> that we avoid adding more entries to the global mode database.
> 
> It boots but the picture is stretched over the display. That's what I
> first tried, too, but only adding the mode definition fixed it.

Okay.

Tony


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
