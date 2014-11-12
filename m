From: Rob Herring <robherring2@gmail.com>
Date: Wed, 12 Nov 2014 17:43:56 +0000
Subject: Re: [PATCH v4 2/5] dt-bindings: Add a clocks property to the simple-framebuffer binding
Message-Id: <CAL_Jsq+fzmTOSr8g+6b5R=KPao1ZeumsyNS3nfYBzfVQCiPbWA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
 <1413996311-4287-3-git-send-email-hdegoede@redhat.com>
 <20141111214217.19EF5C41610@trevor.secretlab.ca>
 <546373C6.4010001@redhat.com>
 <CACxGe6v15EjpALit4ZJLXDgCkwEYM4t1mryjoQpa3=wpKmXWEg@mail.gmail.com>
 <CACxGe6vBq5Y6HbogbpVUy9VLaocfrAsR_XRbio4zBB_vY5GRsw@mail.gmail.com>
In-Reply-To: <CACxGe6vBq5Y6HbogbpVUy9VLaocfrAsR_XRbio4zBB_vY5GRsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Nov 12, 2014 at 10:38 AM, Grant Likely <grant.likely@linaro.org> wrote:
> Rob, seeing as we disagree on patch #5, do you have time to discuss this
> evening, or tomorrow?

Yes, either is fine.

Rob

>
> g.
>
> On 12 Nov 2014 14:56, "Grant Likely" <grant.likely@linaro.org> wrote:
>>
>> [Replying on-list and with original ccs]
>>
>> On Wed, Nov 12, 2014 at 2:50 PM, Hans de Goede <hdegoede@redhat.com>
>> wrote:
>> > Hi,
>> >
>> > On 11/11/2014 10:42 PM, Grant Likely wrote:
>> >> - clocks : List of clocks used by the framebuffer. Clocks listed here
>> >>            are expected to already be configured correctly. The OS must
>> >>            ensure these clocks are not modified or disabled while the
>> >>            simple framebuffer remains active.
>> >
>> > Updated in my local tree, where I've also added proper commit messages
>> > to the 2 patches missing them. Shall I send a v5 of the set, and may I
>> > add your Acked-by to this patch when sending v5?
>>
>> For this whole series, please add my Acked-by.
>>
>> Acked-by: Grant Likely <grant.likely@linaro.org>
>>
>> I'm okay with the bindings, and I'm okay with adding the clock
>> dependency to a simplefb node. I'm happy with the conversation we had
>> today on IRC, and I'm expecting to see a binding that covers expected
>> firmware/OS behaviour and association with the real hardware posted to
>> the list shortly.
>>
>> g.
