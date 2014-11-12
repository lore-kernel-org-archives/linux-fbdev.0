From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 12 Nov 2014 15:27:00 +0000
Subject: Re: [PATCH v4 2/5] dt-bindings: Add a clocks property to the simple-framebuffer binding
Message-Id: <54637C44.8050208@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
 <1413996311-4287-3-git-send-email-hdegoede@redhat.com>
 <20141111214217.19EF5C41610@trevor.secretlab.ca>
 <546373C6.4010001@redhat.com>
 <CACxGe6v15EjpALit4ZJLXDgCkwEYM4t1mryjoQpa3=wpKmXWEg@mail.gmail.com>
In-Reply-To: <CACxGe6v15EjpALit4ZJLXDgCkwEYM4t1mryjoQpa3=wpKmXWEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 11/12/2014 03:56 PM, Grant Likely wrote:
> [Replying on-list and with original ccs]
> 
> On Wed, Nov 12, 2014 at 2:50 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 11/11/2014 10:42 PM, Grant Likely wrote:
>>> - clocks : List of clocks used by the framebuffer. Clocks listed here
>>>            are expected to already be configured correctly. The OS must
>>>            ensure these clocks are not modified or disabled while the
>>>            simple framebuffer remains active.
>>
>> Updated in my local tree, where I've also added proper commit messages
>> to the 2 patches missing them. Shall I send a v5 of the set, and may I
>> add your Acked-by to this patch when sending v5?
> 
> For this whole series, please add my Acked-by.
> 
> Acked-by: Grant Likely <grant.likely@linaro.org>

Thanks, given the above update to the bindings text, and also some updated
commit messages, I'll post a v5 with all these added soon.

Regards,

Hans
