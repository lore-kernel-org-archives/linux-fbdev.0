From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: cursor maddnes and a solution
Date: Wed, 10 Aug 2005 02:58:48 -0400
Message-ID: <9e4733910508092358360f8bc8@mail.gmail.com>
References: <Pine.LNX.4.56.0508090115420.2749@pentafluge.infradead.org>
	 <42F99B5E.1070309@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2kYA-00014t-Gv
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 23:58:54 -0700
Received: from wproxy.gmail.com ([64.233.184.192])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E2kYA-00030w-Fk
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 23:58:54 -0700
Received: by wproxy.gmail.com with SMTP id i3so69725wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Aug 2005 23:58:48 -0700 (PDT)
In-Reply-To: <42F99B5E.1070309@gmail.com>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: James Simmons <jsimmons@infradead.org>

You have a cursor and a caret. The caret is used for typing text and
the cursor follows the mouse.

Next you are are either in text or graphics mode. How you generate the
caret/cursor is quite different in the two modes. User space doesn't
care about text mode so you can handle it in fbconsole. I'm not sure
how gdm generates a mouse cursor in text mode. Since it is fairly easy
to generate the cursor/caret in software in text mode, I don't know it
if it worth the effort to try and use hardware support.

In graphics mode user space will use the hardware mouse cursor if it
is available. I believe there are a few chips that support multiple
sprites, one could be used for the cursor and one for the caret. This
isn't common so the caret is almost always software generated.

The hardware mouse cursor is relevant in graphics mode because you may
not be able to generate screens in real time. If you can't the
software mouse cursor lags and may become unusable. Hardware mouse
cursor eliminates this problem.

Graphical fbconsole doesn't have a lag problem so it may just want to
software generate.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
