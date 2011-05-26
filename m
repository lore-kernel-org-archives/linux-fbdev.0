From: Andrew Lutomirski <luto@mit.edu>
Date: Thu, 26 May 2011 04:09:31 +0000
Subject: Re: efifb not detected on Intel DQ67SW
Message-Id: <BANLkTi=N4R976HapSin7T3kLkhEZVBWP_w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <BANLkTikxX577VKmPRVGcp_Chj-udCf-KaQ@mail.gmail.com>
In-Reply-To: <BANLkTikxX577VKmPRVGcp_Chj-udCf-KaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Wed, May 25, 2011 at 2:54 PM, Andrew Lutomirski <luto@mit.edu> wrote:
> On Wed, May 25, 2011 at 2:32 PM, Matthew Garrett <mjg@redhat.com> wrote:
>> On Wed, May 25, 2011 at 02:21:17PM -0400, Andrew Lutomirski wrote:
>>
>>> Looking at the code, I'm a little confused how it's supposed to work.
>>> AFAICT, unless there's a DMI match, then the driver will only load
>>> ifthe boot code sets VIDEO_TYPE_EFI, but nothing sets that.
>>
>> grub should be setting that.
>
> It looks like grub-fedora (the git version, anyway) has a function
> set_kernel_params that tries to do this. =A0Peter, the git tree claims
> that you maintain it. =A0Are there any experiments you'd like me to do?
> (Dumping boot_params, perhaps?)

It's a bug in grub.  If I have a splashimage then efifb works.  If I
don't, then efifb doesn't.  If I don't hear anything back soon, I'll
file a bug against Fedora.

FWIW, efifb seems really slow.

--Andy

>
> --Andy
>
