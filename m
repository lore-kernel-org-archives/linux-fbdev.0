From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2002-Q4@gmx.net>
Subject: Re: Linux 2.4.20-rc1
Date: Fri, 08 Nov 2002 13:22:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <3DCBAC99.7010909@gmx.net>
References: <Pine.LNX.4.44L.0211061033410.27268-100000@freak.distro.conectiva> <3DCAAF2D.2040202@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040407030801040902040307"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------040407030801040902040307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Carl-Daniel Hailfinger wrote:
> [CC: linux-fbdev-devel to find out what was wrong with the patch]
> Marcelo Tosatti wrote:
>> On Sat, 2 Nov 2002, Carl-Daniel Hailfinger wrote:
>>> Marcelo Tosatti wrote:
>>>
>>>> Hi,
>>>>
>>>> Finally, rc1.
>>>> [snipped]
>>>>
>>>> Please stress test it.
>>>>
>>>
>>> My system comes up with a blank console after hardware suspend and 
>>> resume.
>>> The cursor is still visible, but no text is there. Switching to another
>>> console and back fixes it. Vesafb is enabled with vga=791.
>>> Hardware is a Toshiba Satellite 4100XCDT notebook with Trident 
>>> Cyber9525DVD
>>> graphics chipset, but this also can be reproduced with Dell notebooks.
>>>
>>> I just verified the problem exists still with 2.4.20-rc1.
>>> A binary search turned up 2.4.18-pre7 as the kernel which broke,
>>> specifically the changes made to apm.c back then.
>>
>>
>>
>> Have you tried to revert 2.4.18-pre7's changes to apm.c to make sure 
>> it is
>> the cause?>
> 
> 
> I tried it and found out that my results were incorrect. The problem was 
> introduced in 2.4.18-pre1 by the changes to drivers/video/fbcon.c
> 
> Reverting the attached patch fixes my problem. However, I am not exactly 
> sure why a patch intended to fix a PM problem introduced another one.

I managed to trim down the offending patch further. Reverting the new 
attached patch is enough to fix my problem. Can someone of the framebuffer 
experts please comment on this one?

Regards
Carl-Daniel

--------------040407030801040902040307
Content-Type: application/x-java-vm;
 name="patch-fbdev-5"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="patch-fbdev-5"

ZGlmZiAtTmF1ciAtWCAvaG9tZS9tYXJjZWxvL2xpYi9kb250ZGlmZiBsaW51eC5vcmlnL2Ry
aXZlcnMvdmlkZW8vZmJjb24uYyBsaW51eC9kcml2ZXJzL3ZpZGVvL2ZiY29uLmMKLS0tIGxp
bnV4Lm9yaWcvZHJpdmVycy92aWRlby9mYmNvbi5jCVRodSBKYW4gMTAgMjA6MTc6NDEgMjAw
MgorKysgbGludXgvZHJpdmVycy92aWRlby9mYmNvbi5jCVdlZCBEZWMgMjYgMTY6NTA6NTIg
MjAwMQpAQCAtMTU1OCw2ICsxNTcxLDEwIEBACiAKICAgICBpZiAoYmxhbmsgPCAwKQkvKiBF
bnRlcmluZyBncmFwaGljcyBtb2RlICovCiAJcmV0dXJuIDA7CisjaWZkZWYgQ09ORklHX1BN
CisgICAgaWYgKGZiY29uX3NsZWVwaW5nKQorICAgIAlyZXR1cm4gMDsKKyNlbmRpZiAvKiBD
T05GSUdfUE0gKi8KIAogICAgIGZiY29uX2N1cnNvcihwLT5jb25wLCBibGFuayA/IENNX0VS
QVNFIDogQ01fRFJBVyk7CiAK
--------------040407030801040902040307--
