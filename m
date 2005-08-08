From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Regression: radeonfb: No synchronisation on CRT with linux-2.6.13-rc5
Date: Sun, 7 Aug 2005 22:41:45 -0400
Message-ID: <2F9E1CB1-CAF5-491A-A410-CFD6E2FEAD07@mac.com>
References: <Pine.LNX.4.58.0508040103100.2220@be1.lrz> <1123195493.30257.75.camel@gaston> <Pine.LNX.4.58.0508051935570.2326@be1.lrz> <1123401069.30257.102.camel@gaston> <3EF2003B-12DF-4EBB-B304-59614AEFAA09@mac.com> <1123431219.30257.115.camel@gaston> <96358AEB-784F-444E-A0BA-04AD920284B3@mac.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v733)
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1xaQ-0000VS-GY
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 19:41:58 -0700
Received: from smtpout.mac.com ([17.250.248.97])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1xaQ-0003vi-Dp
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 19:41:58 -0700
In-Reply-To: <96358AEB-784F-444E-A0BA-04AD920284B3@mac.com>
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
Content-Type: text/plain; charset="us-ascii"; delsp="yes"; format="flowed"
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bodo Eggert <7eggert@gmx.de>, LKML <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net

On Aug 7, 2005, at 21:13:54, Kyle Moffett wrote:
> On Aug 7, 2005, at 12:13:38, Benjamin Herrenschmidt wrote:
>> _However_ there is an unrelated problem with some panels,  
>> including some
>> of the 17": The panel doesn't always "sync" properly. This seem to be
>> related to some subtle timing issue in the LVDS code but I don't know
>> exactly what yet. You can usually get it back by repeately turning  
>> the
>> backlight all the way down (which shuts the panel off) and back up  
>> until
>> it "catches".
>
> Hmm.  This doesn't really fit as my issues are very reproducible.  The
> behaviour under stock Debian 2.6.8 is identical during reboots and  
> after
> fblevel 0 ; sleep X ; fblevel 15.  Likewise, stock 2.6.11,  
> 2.6.12.4, and
> 2.6.13-rc5, although I'm just getting back to testing things.

Damn.  As soon as I say this, I go back and am completely unable to make
2.6.13-rc5 reproduce the issue.  *grumble* black magic *grumble* :-D.

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so
simple that there are obviously no deficiencies. And the other way is  
to make
it so complicated that there are no obvious deficiencies.  The first  
method is
far more difficult.
   -- C.A.R. Hoare




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
