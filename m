From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 07 May 2013 16:45:54 +0000
Subject: Re: [PATCH 3/7] drm: Update drm_addmap and drm_mmap to use PAT WC instead of MTRRs
Message-Id: <CALCETrUcwmq5MxmSgUZj8G612fUWvTtme39MAnqyPjHR+99dVQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1367621038.git.luto@amacapital.net> <d6e5e371e464b7de1115a00f02b5b834315cd986.1367621039.git.luto@amacapital.net>
 <CALCETrVe=JSPB=x79e1fAK=DrMgo7_Liagihib9quJDJ0N670Q@mail.gmail.com>
 <CAH3drwYSZVrM4uWwFAxD+c0n1Q9i-et=Mwbk253E+cd+BtW9yw@mail.gmail.com>
 <CALCETrXO7OVxjw5nJ+HrBP7yAoAXk14w1cMbWBC4ZdBmZ6-3JQ@mail.gmail.com> <CADnq5_OJF5NB8r3Pj5E9VaiBLMTyHtERC4N4X0yYLwXQLqqrmw@mail.gmail.com>
In-Reply-To: <CADnq5_OJF5NB8r3Pj5E9VaiBLMTyHtERC4N4X0yYLwXQLqqrmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Jerome Glisse <j.glisse@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Tue, May 7, 2013 at 7:08 AM, Alex Deucher <alexdeucher@gmail.com> wrote:
> On Mon, May 6, 2013 at 7:39 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> On Mon, May 6, 2013 at 4:04 PM, Jerome Glisse <j.glisse@gmail.com> wrote:
>>> On Mon, May 6, 2013 at 5:22 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>>> On Fri, May 3, 2013 at 4:00 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>>>> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
>>>>> ---
>>>>>
>>>>> This needs careful review.  I don't really know what this code does, nor
>>>>> do I have the hardware.  (I don't understand AGP and the associated
>>>>> caching implications.)
>>>>
>>>> This patch is wrong (I didn't update the matching mtrr_del), and I'm
>>>> reworking this whole series.  But I may need some help on this one:
>>>> why is the mtrr handle of a map (whatever a map is) exported to
>>>> userspace via the ADD_MAP and GET_MAP ioctls?  What (if anything) is
>>>> userspace supposed to do with it?  Do I need to return a valid MTRR
>>>> register number?  Is there any userspace code at all that sets
>>>> _DRM_WRITE_COMBINING in DRM_IOCTL_ADD_MAP with appropriate alignment
>>>> and needs the MTRR, for which the drm driver doesn't already add the
>>>> MTRR?
>>>>
>>>> --Andy
>>>
>>> From memory, even on pat system we need mtrr for VRAM is PCI BAR. We
>>> cover it with a write combine MTRR. The whole ioctl is use by some ddx
>>> or maybe even directly the XServer to do this mtrr mess in userspace.
>>
>> Egads!  So we have a _DRM_WRITE_COMBINING flag, which will continue to
>> work fine, but almost nothing uses it.
>>
>> I'm amazed this stuff works in the current code, though.  Apparently
>> the memory type (WC or UC) of a drm mapping is determined by the mtrr
>> the driver set, but if one part of the BAR is textures or the
>> framebuffer and another part is an outgoing command ring, won't one of
>> them end up with the wrong memory type?
>
> A lot of old chips used to put the registers and framebuffer in the
> same BAR.  IIRC, the xserver and later libpciaccess had workarounds to
> deal with this.

I think I read the code wrong (so my patch is garbage).  Maybe there's
actually no problem -- if DRM_AGP and DRM_FRAME_BUFFER are always WC,
DRM_REGISTERS is only WC if explicitly requested, and DRM_SHM is
always WB, so everything should be covered.

Anything using libpciaccess ought to be unaffected by my changes -- I
don't want to change /proc/mtrr or the sysfs stuff.  The only possible
issue is if there's a memtype conflict, but that's nothing new.

--Andy
