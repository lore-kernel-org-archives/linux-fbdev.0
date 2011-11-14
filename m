From: "D.J.J. Ring, Jr." <n1ea@arrl.net>
Date: Mon, 14 Nov 2011 20:09:40 +0000
Subject: Re: Getting FB to work in Console
Message-Id: <CADO5Rbg2TC1hXiiEBpfcnnPKNY0goQm4jGaMgzuLL6sOJQ1nMw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
In-Reply-To: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

I am sorry Anatolij,

I should have said that I DID run sudo update-grub and then I rebooted.

When it rebooted, I still have the "no /dev/fb0" error.

I apologize for not being thourough in my words.

David
David J. Ring, Jr., N1EA
SOWP, VWOA, OOTC, FISTS, CW-Ops, CFO, A1-OP, ex-FOC 1271 ARRL-LM
Chat Skype: djringjr MSN: djringjr@msn.com AIM: N1EA icq: 27380609
Radio-Officers Google Group -- Marine Morse Historic Recordings Page



On Mon, Nov 14, 2011 at 1:58 PM, Anatolij Gustschin <agust@denx.de> wrote:
> Hello David,
>
> On Mon, 14 Nov 2011 01:09:53 -0500 (EST)
> David J Ring Jr <n1ea@arrl.net> wrote:
>
>> I found a line in /etc/default/grub which has nomodeset in it and I
>> disabled it.
>>
>> Here is what I have in that file now.
>>
>> I have a feeling that something in grub is not right.
>
> Did you run 'sudo update-grub' command after changing the /etc/default/gr=
ub
> file ? If not, then the actual grub configuration file was not
> updated and you probably still have nomodeset on the kernel command
> line.
>
>> # If you change this file, run 'update-grub' afterwards to update
>> # /boot/grub/grub.cfg.
>>
>> GRUB_DEFAULT=3D0
>> GRUB_TIMEOUT=3D5
>> GRUB_DISTRIBUTOR=3D`lsb_release -i -s 2> /dev/null || echo Debian`
>> #GRUB_CMDLINE_LINUX_DEFAULT=3D"nomodeset"
>> GRUB_CMDLINE_LINUX=3D""
> ...
>> What do you think? =A0Is this where nomodeset is and does it look like t=
his
>> should work? =A0I still cannot get /dev/fb0
>
> It should work. If you additionally run 'sudo update-grub', the grub
> configuration file /boot/grub/grub.cfg will be updated. Then nomodeset
> shouldn't be passed on the kernel command line any more.
>
> Anatolij
>
