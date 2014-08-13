From: David Herrmann <dh.herrmann@gmail.com>
Date: Wed, 13 Aug 2014 08:50:51 +0000
Subject: Re: [PATCH 1/4] simplefb: formalize pseudo palette handling
Message-Id: <CANq1E4Q01JEvfCZuvPaUmEo7VmaFt3U=xjrPnLHSJcfk3AhZMw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-2-git-send-email-libv@skynet.be>
 <CANq1E4ShhaUMT3MpAei4sgo7Nr-jHfD+TpF8dzAVbn58Feroiw@mail.gmail.com>
 <CAMuHMdVROkKvW1VYWbOtecO9sQAudtgS-mJtZb5ZLUCMaZdGAA@mail.gmail.com>
In-Reply-To: <CAMuHMdVROkKvW1VYWbOtecO9sQAudtgS-mJtZb5ZLUCMaZdGAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi

On Wed, Aug 13, 2014 at 10:46 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Aug 13, 2014 at 9:25 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
>>> @@ -225,7 +234,7 @@ static int simplefb_probe(struct platform_device *pdev)
>>>                 framebuffer_release(info);
>>>                 return -ENODEV;
>>>         }
>>> -       info->pseudo_palette = (void *)(info + 1);
>>> +       info->pseudo_palette = (void *) par->palette;
>>
>> I think coding-style is this (i.e., no whitespace):
>>     info->pseudo_palette = (void*)par->palette;
>
> <casts-are-evil>
> Is this cast even needed?
> </casts-are-evil>

"pseudo_palette" is "void*", so not at all.

Thanks
David
