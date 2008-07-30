From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc9 4/5] metronomefb: convert
	printk to dev_dbg/err messages
Date: Tue, 29 Jul 2008 23:18:08 -0400
Message-ID: <45a44e480807292018u307f9e1asa2b6b5319034e846@mail.gmail.com>
References: <1217046774-13080-1-git-send-email-jayakumar.lkml@gmail.com>
	<1217046774-13080-5-git-send-email-jayakumar.lkml@gmail.com>
	<f17812d70807291950y6f10fc2dk49e1fca82773e36a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KO2CZ-0006Bl-Md for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jul 2008 20:18:11 -0700
Received: from nf-out-0910.google.com ([64.233.182.184])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KO2CY-0008CD-77
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jul 2008 20:18:11 -0700
Received: by nf-out-0910.google.com with SMTP id g16so50308nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 29 Jul 2008 20:18:08 -0700 (PDT)
In-Reply-To: <f17812d70807291950y6f10fc2dk49e1fca82773e36a@mail.gmail.com>
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
To: Eric Miao <eric.y.miao@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Tue, Jul 29, 2008 at 10:50 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Sat, Jul 26, 2008 at 12:32 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>> This patch converts the printk messages in metronomefb to dev_dbg/err type
>> messages.
>>
>
> I think this is already Acked (except for the DEBUG definition), so it would
> probably nice if you can re-order the patch series and put this in the front,
> so the next time we can focus on those patches with concerns only, and
> get things merged a bit quicker.
>
> That will take you sometime, though. Sorry about that and thanks for the
> good work.

Hi Eric,

No worries. Yup, I'll take DEBUG out before posting final. Thanks for
the review.

Regards,
jaya

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
