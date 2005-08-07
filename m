From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Regression: radeonfb: No synchronisation on CRT with linux-2.6.13-rc5
Date: Sun, 7 Aug 2005 09:45:25 -0400
Message-ID: <3EF2003B-12DF-4EBB-B304-59614AEFAA09@mac.com>
References: <Pine.LNX.4.58.0508040103100.2220@be1.lrz> <1123195493.30257.75.camel@gaston> <Pine.LNX.4.58.0508051935570.2326@be1.lrz> <1123401069.30257.102.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v733)
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1lT4-0005ET-Mw
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 06:45:34 -0700
Received: from smtpout.mac.com ([17.250.248.87])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1lT4-000384-I3
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 06:45:34 -0700
In-Reply-To: <1123401069.30257.102.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bodo Eggert <7eggert@gmx.de>, LKML <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net

On Aug 7, 2005, at 03:51:07, Benjamin Herrenschmidt wrote:
> On Fri, 2005-08-05 at 19:38 +0200, Bodo Eggert wrote:
>> On Fri, 5 Aug 2005, Benjamin Herrenschmidt wrote:
>>
>>> On Fri, 2005-08-05 at 00:03 +0200, Bodo Eggert wrote:
>>>> My CRT is out of sync after radeonfb from 2.6.13-rc5 is  
>>>> initialized.
>>>> 2.6.12 does not show this behaviour.
>>>
>>> I'm out of town at the moment, could you maybe diff radeonfb between
>>> working & non-working and CC me the diff ? I don't have my work  
>>> stuff at
>>> hand not my kernel images so...
>>
>> There were no changes in radeonfb.c, but I could trace to to
>> CONFIG_PREEMPT. With _NONE, it works as expected.
>
> Ah ! Interesting... I don't see why PREEMPT would affect radeonfb
> though ... Can you try something like wrapper radeon_write_mode() with
> preempt_disable()/preempt_enable() and tell me if it makes a
> difference ?

I'm having a similar issue with my shiny new 17" Powerbook G4.  The
radeon chip works fine with framebuffer in 2.6.12.4 _with_ PREEMPT,
but not in 2.6.13-rc5 _with_ PREEMPT (configs are virtually identical).
I'll try your idea this afternoon when I get the chance.

I wonder if perhaps some code in radeonfb is used under the BKL, which
is now preemptable (Or maybe an ordinary spinlock changed or went
away?), because I also set PREEMPT_BKL.  I've got an LCD, and on mine
it looks like every third pixel-line gets shifted about 32-64 pixels to
the left, and they move with display refresh.  My guess is that
something is interrupting radeonfb during a critical time in display
syncing and forcing the video card to wait too far into the next line
before sending pixels.

One other data point, I've seen something like this, except not nearly
as bad, is stock debian 2.6.8 vs. stock debian 2.6.11 on powerpc.  The
former exhibits some similar (but not nearly as bad) symptoms.  (Same
Powerbook), whereas 2.6.11 doesn't.  In that case, neither has PREEMPT.
I'll run more tests this afternoon/evening, to try to track it down.

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
