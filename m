From: Daniel Mack <daniel@zonque.org>
Date: Sun, 24 Jun 2018 15:34:17 +0000
Subject: Re: [PATCH v2] video: fbdev: pxafb: zero allocated memory for video modes
Message-Id: <fc6cf8a4-174b-d534-9d16-bc3660f7697d@zonque.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180619131332.23741-1-daniel@zonque.org>
In-Reply-To: <20180619131332.23741-1-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thursday, June 21, 2018 12:39 PM, Bartlomiej Zolnierkiewicz wrote:
> On Thursday, June 21, 2018 11:22:35 AM Robert Jarzmik wrote:
>> Daniel Mack <daniel@zonque.org> writes:
>>
>>> On Tuesday, June 19, 2018 10:11 PM, Robert Jarzmik wrote:
>>>> Daniel Mack <daniel@zonque.org> writes:
>>>>
>>>>> When parsing the video modes from DT properties, make sure to zero out
>>>>> memory befor using it. This is important because not all fields in the mode
>>>> s/befor/before/
>>>>
>>>
>>> Yeah, seen this too after sending. Should I resend, or can this be amended when
>>> applying?
>> I think this question is for Bartlomiej, as fbdev is his tree ...
> 
> I will fix this typo while applying, no need for resend..

Hang on. I have some more patches on top, so I'll resend this one as 
part of a bigger series soon.


Thanks,
Daniel
