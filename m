From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] cirrusfb: it lives!
Date: Tue, 22 Jun 2004 13:53:31 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040622135331.3d1509b2.akpm@osdl.org>
References: <20040622202758.GA10135@havoc.gtf.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BcsE8-0004wT-4X
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Jun 2004 13:50:44 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BcsE7-0006l7-NQ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Jun 2004 13:50:43 -0700
In-Reply-To: <20040622202758.GA10135@havoc.gtf.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: David Eger <eger@havoc.gtf.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, garzik@havoc.gtf.org, jsimmons@infradead.org

David Eger <eger@havoc.gtf.org> wrote:
>
> This patch brings the cirrusfb driver up to date with 2.6.

Ol=E9

> cirrusfb
> has suffered bit rot like you wouldn't believe (last updated... 2.3.x era=
?).

My more venerable testbox has Cirrus hardware.  The problems have been note=
d ;)

> The driver will now compile again, and you can change to a high resolutio=
n=20
> text mode with stty.  Known defects: doesn't play nice with X, nor fbset.
> Nonetheless, please apply to -mm and forward to mainline.

Shall do, thanks.


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
