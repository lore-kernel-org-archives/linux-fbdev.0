From: "Antonino Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 23/24] matroxfb: Color setting fixes
Date: Sun, 3 Jun 2007 17:59:18 +0800
Message-ID: <b00ca3bd0706030259mf808c17g25246aac5876547d@mail.gmail.com>
References: <46614341.5040402@gmail.com> <46625313.9050109@vc.cvut.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Humro-0003lQ-T2 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Jun 2007 02:59:21 -0700
Received: from wa-out-1112.google.com ([209.85.146.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Humrn-0004fW-M2
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Jun 2007 02:59:20 -0700
Received: by wa-out-1112.google.com with SMTP id v33so2730008wah
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 03 Jun 2007 02:59:19 -0700 (PDT)
In-Reply-To: <46625313.9050109@vc.cvut.cz>
Content-Disposition: inline
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 6/3/07, Petr Vandrovec <vandrove@vc.cvut.cz> wrote:
> Antonino A. Daplas wrote:
> > - the pseudo_palette is only 16 elements long.
> > - do not write to the pseudo_palette if regno (array index) is more than 15
> >
> > Signed-off-by: Antonino Daplas <adaplas@gmail.com>
>
> NACK.  If you want to remove entry #16, you need to also fix all uses of
> it - matroxfb_crtc2 uses it, matroxfb_accel as well.  Before hardware
> cursor was removed from fbcon it was used by hardware cursor - now it is
> only set, but never used.  Removing entry without removing code to set
> entry #16 memory corruption will occur.
>                                                                 Petr

Okay, I see it now.  Andrew, drop the patch for matroxfb.

Petr,

Do you have plans for the 17th entry?

Tony

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
