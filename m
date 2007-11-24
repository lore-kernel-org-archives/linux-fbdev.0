From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: Questions about fbdriver integration
Date: Sat, 24 Nov 2007 17:49:52 -0500
Message-ID: <45a44e480711241449l5c368250q40e5adc1fab117fa@mail.gmail.com>
References: <20071124214325.GD3183@pruts.nl> <20071124221447.GF3183@pruts.nl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Iw3ow-0001fa-GW for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Nov 2007 14:49:54 -0800
Received: from rv-out-0910.google.com ([209.85.198.191])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Iw3ov-0006LC-AT
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Nov 2007 14:49:54 -0800
Received: by rv-out-0910.google.com with SMTP id g11so542455rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 24 Nov 2007 14:49:53 -0800 (PST)
In-Reply-To: <20071124221447.GF3183@pruts.nl>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

On Nov 24, 2007 5:14 PM, Ico Doornekamp <fbdev@zevv.nl> wrote:
> Is the deferred IO code currently known to work properly ?
>

The deferred IO code does not work properly at the moment. The symptom
is that only the first write to the framebuffer is detected. I have a
patch to fix this which I've tested to work on 2.6.22.10. You can
cherrypick the fb_defio.c changes from the following post.

http://marc.info/?l=linux-fbdev-devel&m=119412505902140&w=2

Best regards,
jaya

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
