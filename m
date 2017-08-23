From: David Lechner <david@lechnology.com>
Date: Wed, 23 Aug 2017 15:58:15 +0000
Subject: Re: [PATCH v3] fbcon: add fbcon=margin:<color> command line option
Message-Id: <dc3757f4-b542-8a5a-cfe7-a6f6a63196b8@lechnology.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501605357-30815-1-git-send-email-david@lechnology.com>
 <CGME20170818191930epcas3p16e6cac84fc9579a57208110214773221@epcas3p1.samsung.com>
 <0f404f59-f494-bd33-9a9a-f9b07a0dd7ee@lechnology.com>
 <1712803.5baJPN1EnC@amdc3058>
In-Reply-To: <1712803.5baJPN1EnC@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 08/23/2017 10:56 AM, Bartlomiej Zolnierkiewicz wrote:
> 

>>>
>>> Given the standard console palette contains 16 colors, why limit this to
>>> the first 8 colors, and not 0 to 15?
>>
>> Good question. I think in some of my previous attempts there was a 0x7
>> mask involved somewhere and this is a carryover from that. But, after
>> having looked at this again, I don't see a reason for limiting to 7.
> 
> Could you please prepare the incremental patch raising the number of colors
> possible to use?

Yes, I will do this.
