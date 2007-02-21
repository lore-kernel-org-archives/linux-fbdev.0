From: Alex Romosan <romosan@sycorax.lbl.gov>
Subject: Re: no backlight on radeon after recent kernel "upgrade"s
Date: Wed, 21 Feb 2007 14:18:13 -0800
Message-ID: <877iub9mu2.fsf@sycorax.lbl.gov>
References: <20070219044616.GC25659@washoe.onerussian.com>
	<20070219000412.acad13de.akpm@linux-foundation.org>
	<1171876788.6046.3.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1423201AbXBUWZm@vger.kernel.org>
In-Reply-To: <1171876788.6046.3.camel@localhost.localdomain> (message from
	Richard Purdie on Mon, 19 Feb 2007 09:19:48 +0000)
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Yaroslav Halchenko <kernel@onerussian.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Richard Purdie <rpurdie@rpsys.net> writes:

> On Mon, 2007-02-19 at 00:04 -0800, Andrew Morton wrote:
>> On Sun, 18 Feb 2007 23:46:16 -0500 Yaroslav Halchenko <kernel@onerussian.com> wrote:
>> > Since the most recent successful for me kernel 2.6.19-rc6-mm1, I've
>> > tried few times to build more recent snapshots and now finally
>> > 2.6.20-mm2. In all those cases I have a sad outcome -- kernel boots but
>> > at some point during boot (few moments after Penguin icon in the top left
>> > corner appears), light turns off... I still can see something, especially
>> > if I light a strong flashlight at a sharp angle.
>> > 
>> > I've enabled back-light support and lcd support for those unsuccessful
>> > kernels (with all backlight support features disabled kernel boots
>> > ok and backlight shines as bright as always)
>>
>> Is 2.6.20 broken?  I assume the latest 2.6.20-gitN snapshot are failing..
>
> It would be extremely useful to know which kernel versions you tested
> and which ones failed. There are a number of backlight changes which are
> just in 2.6.20-mm1 and -mm2 which it would be useful to rule out or
> identify as the cause.

i have exactly the same problem with 2.6.21-rc1 on a thinkpad t40
with an ati radeon card. the machine boots up but the backlight never
comes on. 2.6.20 worked okay.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
