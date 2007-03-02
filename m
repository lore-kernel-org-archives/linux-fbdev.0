From: Alex Romosan <romosan@sycorax.lbl.gov>
Subject: Re: 2.6.21-rc2 radeon backlight
Date: Fri, 02 Mar 2007 09:24:03 -0800
Message-ID: <87tzx35zkc.fsf@sycorax.lbl.gov>
References: <87ps7uutsk.fsf@sycorax.lbl.gov>
	<20070301184531.b3aeafe3.akpm@linux-foundation.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992656AbXCBRZP@vger.kernel.org>
In-Reply-To: <20070301184531.b3aeafe3.akpm@linux-foundation.org> (message from
	Andrew Morton on Thu, 1 Mar 2007 18:45:31 -0800)
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Richard Purdie <rpurdie@rpsys.net>

Andrew Morton <akpm@linux-foundation.org> writes:

> On Wed, 28 Feb 2007 08:32:43 -0800
> Alex Romosan <romosan@sycorax.lbl.gov> wrote:
>
>> the backlight on my thinkpad still (2.6.20 worked fine) doesn't come
>> on if i have the radeon backlight enabled. without it, i guess it's
>> the ibm acpi modules that controls the backlight and it seems to work
>> fine.
>> 
>
> Unclear. Are you saying that the backlight comes on OK if you use
> the IBM acpi module?

yes, if i disable the radeon backlight and use the ibm acpi module,
than the backlight works. if i enable the radeon backlight, the screen
stays dark and i can't turn it on (i tried using radeontool to control
it but nothing happened).

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
