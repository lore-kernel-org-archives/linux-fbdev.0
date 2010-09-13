From: Peter Jones <pjones@redhat.com>
Date: Mon, 13 Sep 2010 14:52:33 +0000
Subject: Re: [PATCH 1/2] Make efifb check that the base address is plausible
Message-Id: <4C8E3AB1.6010509@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1284059809-9973-1-git-send-email-pjones@redhat.com> <20100910171406.bdb4d90d.akpm@linux-foundation.org> <4C8E3853.70702@redhat.com>
In-Reply-To: <4C8E3853.70702@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/13/2010 10:42 AM, Peter Jones wrote:
> On 09/10/2010 08:14 PM, Andrew Morton wrote:
>> On Thu,  9 Sep 2010 15:16:48 -0400
>> Peter Jones <pjones@redhat.com> wrote:
>>
>>> Some Apple machines have identical DMI data but different memory
>>> configurations for the video. Given that, check that the address in our
>>> table is actually within the range of a PCI BAR on a VGA deivce in the
>>> machine.
>>>
>>> This also fixes up the return value from set_system(), which has
>>> always been wrong, but never resulted in bad behavior since there's only
>>> ever been one matching entry in the dmi table.
>>>
>>> This also adds me as the efifb maintainer, since I've effectively been
>>> acting as such for quite some time.
>>
>> And what is the impact (and importance) of this patch?  Make some
>> people's Mac displays work, I'd be guessing?
>>
> 
> That's correct.

Actually, let me amend that statement to say something entirely different: it
does two things:

1) stops people's machines from crashing when we get their display wrong,
   which seems to be unfortunately inevitable,
2) allows us to support identical dmi data with differing video memory
   configurations

Sorry about the previous reply, I should have thought through your question
for longer.

-- 
        Peter

Hardware simply does not work like the manual says and no amount
of Zen contemplation will ever make you at one with a 3c905B ethernet card.
		-- Alan

01234567890123456789012345678901234567890123456789012345678901234567890123456789
