From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Date: Fri, 10 Jul 2020 13:38:49 +0000
Subject: Re: [PATCH] efi: avoid error message when booting under Xen
Message-Id: <b4e60a2f-e761-d9ad-88ad-fe041109c063@suse.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200610141052.13258-1-jgross@suse.com>
 <094be567-2c82-7d5b-e432-288286c6c3fb@suse.com>
 <CGME20200709091750eucas1p18003b0c8127600369485c62c1e587c22@eucas1p1.samsung.com>
 <ec21b883-dc5c-f3fe-e989-7fa13875a4c4@suse.com>
 <170e01b1-220d-5cb7-03b2-c70ed3ae58e4@samsung.com>
 <CAMj1kXGE52Y6QQhGLU6r_9x6TVftZqfS7zyLCiDusZhV4tbhjg@mail.gmail.com>
In-Reply-To: <CAMj1kXGE52Y6QQhGLU6r_9x6TVftZqfS7zyLCiDusZhV4tbhjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Ard Biesheuvel <ardb@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-efi <linux-efi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Peter Jones <pjones@redhat.com>, xen-devel@lists.xenproject.org

On 10.07.20 15:27, Ard Biesheuvel wrote:
> On Fri, 10 Jul 2020 at 13:17, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
>>
>>
>> [ added EFI Maintainer & ML to Cc: ]
>>
>> Hi,
>>
>> On 7/9/20 11:17 AM, Jürgen Groß wrote:
>>> On 28.06.20 10:50, Jürgen Groß wrote:
>>>> Ping?
>>>>
>>>> On 10.06.20 16:10, Juergen Gross wrote:
>>>>> efifb_probe() will issue an error message in case the kernel is booted
>>>>> as Xen dom0 from UEFI as EFI_MEMMAP won't be set in this case. Avoid
>>>>> that message by calling efi_mem_desc_lookup() only if EFI_PARAVIRT
>>>>> isn't set.
>>>>>
> 
> Why not test for EFI_MEMMAP instead of EFI_BOOT?

Honestly I'm not sure EFI_BOOT is always set in that case. If you tell
me it is fine to just replace the test to check for EFI_MEMMAP I'm fine
to modify my patch.


Juergen
