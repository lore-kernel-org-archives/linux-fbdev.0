From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 14 Nov 2014 09:50:42 +0000
Subject: Re: [PATCH] dt-bindings: simplefb: Document naming scheme for pre-populated simplefb nodes
Message-Id: <5465D072.1000407@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415955751-6316-1-git-send-email-hdegoede@redhat.com>
 <CACxGe6txgJKsybuSrCXzCn8sPJYZVwo-wm+pV5KuTmP=YHiA2g@mail.gmail.com>
In-Reply-To: <CACxGe6txgJKsybuSrCXzCn8sPJYZVwo-wm+pV5KuTmP=YHiA2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 11/14/2014 10:12 AM, Grant Likely wrote:
> On Fri, Nov 14, 2014 at 9:02 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Since we advice to use pre-populated simeplfb nodes in dt files, where the
>> firmware then only needs to fill in the mode info + address and enable it,
>> we should also specify how these pre-populated nodes should be named so
>> that the firmware can find and enable the right one.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  Documentation/devicetree/bindings/video/simple-framebuffer.txt | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer.txt b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
>> index c548f33..01dc948 100644
>> --- a/Documentation/devicetree/bindings/video/simple-framebuffer.txt
>> +++ b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
>> @@ -29,6 +29,13 @@ enable them. This way if e.g. later on support for more display clocks get
>>  added, the simplefb nodes will already contain this info and the firmware
>>  does not need to be updated.
>>
>> +If pre-filled framebuffer nodes are used, they should be named
>> +"framebuffer#-<output>", e.g. "framebuffer0-hdmi". The output should be
>> +included in the name since different outputs typically require different
>> +clocks and the clocks are part of the pre-populated nodes. The firmware must
>> +rename the nodes to the standard "framebuffer@<address>" using the runtime
>> +chosen address when enabling the nodes.
> 
> -<output> should be optional, an only used when there are multiple options.

Right, notice the "should be named", I would rather leave it at that then
complicate the wording by adding something about only use -output when there
are multiple options.

> Something we've not talked about is how to handle a framebuffer that
> has been set up with mirrored displays. Does that case matter?

It is bound to happen sooner or later I guess, but it is still just a single
framebuffer, so from the simplefb kernel driver pov it does not matter, it really
is just another variant on the -<output> theme where there happen to be 2 outputs
active at the same time.

Regards,

Hans



> 
> g.
> 
