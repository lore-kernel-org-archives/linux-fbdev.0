From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH] Add VirtIO Frame Buffer Support
Date: Tue, 03 Nov 2009 17:57:36 +0200
Message-ID: <4AF052F0.4030505@redhat.com>
References: <1257199759-2941-1-git-send-email-agraf@suse.de> <4AEFCBED.50804@redhat.com> <DB868FAB-60AA-4D3A-82AE-A3DAF1AF83B2@suse.de> <4AEFCCBA.9050408@redhat.com> <8BA1853F-11C9-44B1-9FDB-1DFDAED40E1B@suse.de> <4AEFCEDA.4030308@redhat.com> <87F51670-CB3F-431C-87B4-A8746F996C6F@suse.de> <4AEFDF35.3020806@redhat.com> <8EA2855E-4209-4CCA-9E87-1D652A72F8FE@suse.de> <4AEFE7DA.30105@redhat.com> <A955776B-6A8F-491B-969F-28BD8EB8F206@suse.de> <4AEFEF71.5010105@redhat.com> <4AF048E1.90408@codemonkey.ws>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4AF048E1.90408@codemonkey.ws>
Sender: kvm-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Alexander Graf <agraf@suse.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-fbdev-devel@lists.sourceforge.net

On 11/03/2009 05:14 PM, Anthony Liguori wrote:
> Avi Kivity wrote:
>> On 11/03/2009 10:26 AM, Alexander Graf wrote:
>>> Exactly. In fact, I'm even scared to reboot mine because I might end 
>>> up in a 3270 terminal. The whole text only crap keeps people from 
>>> using this platform! And that's what I want to change here.
>>
>> Ok.  I oppose paravirtualization for its own sake and only support it 
>> if there's no other way to get performance.  In this case it buys us 
>> basic functionality which is surprisingly missing on native, that's 
>> arguably even more important.
>
> There is no "native" on s390.  Everything is "paravirtual".

I meant native as in "what they usually do without our stuff".

-- 
error compiling committee.c: too many arguments to function

