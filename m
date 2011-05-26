From: Peter Jones <pjones@redhat.com>
Date: Thu, 26 May 2011 13:56:58 +0000
Subject: Re: efifb not detected on Intel DQ67SW
Message-Id: <4DDE5C2A.7050006@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <BANLkTikxX577VKmPRVGcp_Chj-udCf-KaQ@mail.gmail.com>
In-Reply-To: <BANLkTikxX577VKmPRVGcp_Chj-udCf-KaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 05/26/2011 12:09 AM, Andrew Lutomirski wrote:
> On Wed, May 25, 2011 at 2:54 PM, Andrew Lutomirski <luto@mit.edu> wrote:
>> On Wed, May 25, 2011 at 2:32 PM, Matthew Garrett <mjg@redhat.com> wrote:
>>> On Wed, May 25, 2011 at 02:21:17PM -0400, Andrew Lutomirski wrote:
>>>
>>>> Looking at the code, I'm a little confused how it's supposed to work.
>>>> AFAICT, unless there's a DMI match, then the driver will only load
>>>> ifthe boot code sets VIDEO_TYPE_EFI, but nothing sets that.
>>>
>>> grub should be setting that.
>>
>> It looks like grub-fedora (the git version, anyway) has a function
>> set_kernel_params that tries to do this.  Peter, the git tree claims
>> that you maintain it.  Are there any experiments you'd like me to do?
>> (Dumping boot_params, perhaps?)
> 
> It's a bug in grub.  If I have a splashimage then efifb works.  If I
> don't, then efifb doesn't.  If I don't hear anything back soon, I'll
> file a bug against Fedora.

That's expected, though I admit it's not the best thing ever. We're currently
working on not needing that bootloader at all any more, in favor of grub2,
which doesn't have this limitation.

> FWIW, efifb seems really slow.

It's a non-accelerated console.  Of course it's slow.

-- 
        Peter
