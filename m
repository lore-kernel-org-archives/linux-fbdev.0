From: Avi Kivity <avi@redhat.com>
Subject: Re: [Linux-fbdev-devel] [Qemu-devel] Re: [PATCH] Add VirtIO Frame
 Buffer Support
Date: Tue, 03 Nov 2009 18:05:13 +0200
Message-ID: <4AF054B9.9060204@redhat.com>
References: <1257199759-2941-1-git-send-email-agraf@suse.de> <4AEFCBED.50804@redhat.com> <DB868FAB-60AA-4D3A-82AE-A3DAF1AF83B2@suse.de> <4AEFCCBA.9050408@redhat.com> <8BA1853F-11C9-44B1-9FDB-1DFDAED40E1B@suse.de> <4AEFCEDA.4030308@redhat.com> <87F51670-CB3F-431C-87B4-A8746F996C6F@suse.de> <20091103112543.GA24834@snarc.org> <4AEFFA0A.4040105@redhat.com> <20091103152911.GA8266@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20091103152911.GA8266@localhost>
Sender: kvm-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ondrej Zajicek <santiago@crfreenet.org>
Cc: Vincent Hanquez <tab@snarc.org>, Alexander Graf <agraf@suse.de>, linux-fbdev-devel@lists.sourceforge.net, kvm@vger.kernel.org, qemu-devel@nongnu.org

On 11/03/2009 05:29 PM, Ondrej Zajicek wrote:
> On Tue, Nov 03, 2009 at 11:38:18AM +0200, Avi Kivity wrote:
>    
>> On 11/03/2009 01:25 PM, Vincent Hanquez wrote:
>>      
>>> not sure if i'm missing the point here, but couldn't it be hypothetically
>>> extended to stuff 3d (or video&   more 2d accel ?) commands too ? I can't
>>> imagine the cirrus or stdvga driver be able to do that ever ;)
>>>
>>>        
>> cirrus has pretty good 2d acceleration.  3D is a mega-project though.
>>      
> Cirrus has no blending/compositing hardware support.
> Paravirtualized graphics can easily support full XRender-style
> 2D acceleration.
>    

What do that entail? 3/4 operand raster ops?

-- 
error compiling committee.c: too many arguments to function

