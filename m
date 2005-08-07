From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Re: [PATCH] Don't allow softcursor use from userland
Date: Sun, 7 Aug 2005 00:41:40 -0400
Message-ID: <9e47339105080621415e2f6344@mail.gmail.com>
References: <Pine.LNX.4.56.0508070327550.12196@pentafluge.infradead.org>
	 <20050806212729.0b36a640.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1cyr-0006Rg-Qz
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 06 Aug 2005 21:41:49 -0700
Received: from wproxy.gmail.com ([64.233.184.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1cyq-00015H-Lm
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 06 Aug 2005 21:41:49 -0700
Received: by wproxy.gmail.com with SMTP id i17so359970wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 06 Aug 2005 21:41:42 -0700 (PDT)
In-Reply-To: <20050806212729.0b36a640.akpm@osdl.org>
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
Cc: James Simmons <jsimmons@infradead.org>, geert@linux-m68k.org, adaplas@hotpop.com

On 8/7/05, Andrew Morton <akpm@osdl.org> wrote:
> James Simmons <jsimmons@infradead.org> wrote:
> >
> >  This patch forbids the cursor use from userland. The reason is that th=
e
> >  cursor area could be altered by a another process and the current syst=
em
> >  doesn't handle syncing those updates.
>=20
> Can this change break existing apps?

This change is not agreed too yet. Antonio and I are proposing a
different solution.
http://comments.gmane.org/gmane.linux.fbdev.devel/7118

The alternate solution takes into account that fbconsole is the only
user of softcursor and moves softcursor into console.  fbdev drivers
then only expose a cursor entry point if they have a hardware cursor.
If they don't the entry point is NULL.

Nether solution should break existing apps since the existing
softcursor scheme was broken from user space and unusable.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
