Received: from sonic313-12.consmr.mail.ne1.yahoo.com (sonic313-12.consmr.mail.ne1.yahoo.com [66.163.185.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39CD1990A7
	for <linux-fbdev@vger.kernel.org>; Thu,  8 May 2025 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746729783; cv=none; b=R5DAfIjTXI/MOjBbp1NorJal+2a5/Suc8cYkWi3sQbWIhqwODIpPTAdls9ldO1fQEJPP1PYc6rSvP18EbtY/EFrx53rkUHQCeF9Ox4rBpSumaV7svJSOm29whEqnVlZ1vFCfDDsKewlMmiFTDQ+1lVAN71N9L9J69ApeMr2lrS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746729783; c=relaxed/simple;
	bh=XGCa+FMMesjMcJXxjwQ7EqPg1WDXlquexw/Txkgxwa4=;
	h=Date:From:Subject:To:Cc:Message-Id:MIME-Version:Content-Type:
	 References; b=mtFvQfolkDrVMGMajSdfqdZjbn3iRSBXKwR8aErdrKawv/lQulgGxiw3RhkH9gm1ZqeuXFc23kCkZxOwC01Orrk/GAsxX8yHHuejTVG9lUikFdCmY0xSNa4oV+FERBA0/DgzjlzAF+MpnzsxB3Hep9W2J5G3Z+d8W8rMirXeBkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=att.net; spf=pass smtp.mailfrom=att.net; dkim=pass (1024-bit key) header.d=att.net header.i=@att.net header.b=D62hKBe7; arc=none smtp.client-ip=66.163.185.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=att.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=att.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=att.net header.i=@att.net header.b="D62hKBe7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1746729770; bh=QTPSZu/TpGBGqmDwqXaDiMjbApvo9ziYBrFCUbO9ze8=; h=Date:From:Subject:To:Cc:References:From:Subject:Reply-To; b=D62hKBe7mes5NwWFnhTqE6pWg2K7b39O6nxHSj5i8nzhpszwbgrPKcaXlPvYavWV38ypNGnIiFcTWmHPlbciLZT71jpsOhNJKV/fXat6klAA/WwqnYDQtFraq3OAp0Tjfmy3xy7HAIaez5CKtuLBKVhg1Wi6x4DoncnPdxioeYs=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1746729770; bh=QJKxkW2E6QuDxHoBJGqClUQUScK3qkuGWXzpBFv70ow=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=DOBgY3D7/+MEMb2DwFG//IEEAY57KkQOw/GsXud+dggzexHuN88NdoVcusG0AjiT7cXgF8s0wTOaAPHjcinnyykp/J5Eon6IpT3ONrs5Gg9LBl9VXRdNbH6W00DED5i/320YcHhu5V/j24j6O92yV9s2QBraWfLVzWc6z5KyUtcW05ePxecvuaFfmdVhdG2pJe69xRvXcGJDoHjzrGiLl8rDOr1cUbpcvDUx0IIID4MEd4oW0GQBf3OTFx5xMotIO3uzBfZSHqb6Spxh1qWEIvz8RDceWU2mjIm/7hejcZqSrcMpsJsAfGFFwlTQQ3GGtwlNvFkz9R/LKvXoEs8bKA==
X-YMail-OSG: 1SqVwe0VM1lRIam56CT68tOAaB4JWc0NlCi8TrXwkdLG.V5fCt3Q0qdJtZ92d7V
 4Jgg7JkJvrbmo1GDPgpZ6s_WukheKN6OrfFzkLSeF0pR9DEUzcGjnYau.3eVXwtYNz7p9Hbt_JJJ
 a.jZuGeiVkw3NM1pzqnOIWZzl0HPNUspEEZvtKFI0w0iexxKXsSARHg5W9WSN7HpBslPipE_zVRg
 v8yeV7POfsacn._c.hRqJyofKUQU2Ax4q24NuY6cX3kmHr_lp3FHxnch1JHs1bTl9UjRXiInnL4E
 GoxHKS1ayLgNpVfZ.ZGBDCJ91hHc5tAUyeOKmirp56dpR4mRelGnId_aJG.A77DhC_1hM1CamBD2
 e5Nlow0bzc1fWE5Nh6KWA49o6IaVZuA729iNuEHTt9RtGfSgb0tiNdhtXu7oWDedMVnK27Qjqzc2
 qvcVDZ_Dw3HVqxcDXM4QVQRVr0Zqq1g0s5AgK5K5OmqTyFUlc2EnfDf02JDAfZ9YtbVvl8b2Axup
 HmrQN8V48HmLcxHsiPSYlAEBrURbHatVd_0qnXRZtLhwNnr7ADMjEUWX5CC3Oj5l.Xhv9faWgU3X
 j9oSJDKM2iT3YmlByF8wWuWfay7P_4M2JH_Zftutus2j5pbbCzEnQ2Naw4m8yvbi1NKfb7iGsTrb
 f0YsoHFvwyGHuDJpEJLtONPJ329aqCfhgYQnyFUPPsxhIR.EpULGl5xZjrlPEl3u8IlZ5KagOj4W
 UjReoS7Rck2quZ_iF9msdgvwPAj_lfCRzoHiHDMTT1agVqy9NtacBn.4ChD6d13.jJqzAvD_zVKR
 N6u67tui6kc9qT4VnBVBTmNy.eJgJZu9mdtP9Q1aXgLAgo.IrREXKXb_Y6xsZpkitg2nR4EeL5e7
 B_T5XJWjrOfhJsxW770Ht0Ab15HU1L4tM7YVDJvehRoQgoR0n6N0W1sQB4AX0rVykfj9X46lRmom
 nD9EkrFKdqzKG2YRMon1MOlGWtk40MoIGmsDIyzVjKR7ngMZ4U63ufL3PaJ_iQdZW0iFMTUafRif
 NGj9m_PKKQ5fEA7jMWcJIuRY_TvMX97HNaejCDZxWXTEPRgTPJ2QruFRGgpoXqCYoF6N6vCTDUm_
 UJOXNH9.J6hy02jHmtjYixjtolraqyl1dsht1gOeFFRFndfxxj5z7xxHyt_LWOsmVqFMWD9UMweP
 bZ8Qt5O2enKpzKcuK74mvYMQsBXaQ.gflUENmBYFDCkwwSRf9qqMY81avuasY2QAs0hZ1JTaonHS
 VrIIyAA0ftwx8w0IiYYfT9AepgncV6LmvIKQaNelymQm8HOLfcd6ZTAVFpHJrUwO_thZNdfWZqLX
 I56IT66ugMwXhKZ._0D1TdXr1nkrgDF0EUm12k2FEft91dS4iRFTrvkmi7Bfcr4IIDmVJf17.apC
 UkBTqr.lUquks_ZPjrpLXB3P9ajmKsceFt5MEOBAu30LlUP34qxs3zJ.VfZXqli.8ZlcHb_EGWB2
 AN6w3HNcQK2uCOZttnnMVB9D_zj4z1MAyYv1b0uKg9vysJcL3pzR3cygKlYccCrGwxqExDQEMKA4
 SfE2lZyAqtkJ0nantgnNPjU00lHj121np2xCCwKtTXfNr4Ky_xnZp15TxtoK2QWP.b9jgC1XjgCj
 k2UwLVSFODsARbTGRR4yuQrbfGugNNMCDZGM_aOuVpB1hmf6Suze3aHDGyKGRE6nXRhNWU2dkk2X
 f9QOiucUoME7qN_P1iZovha9_3lqpWUnp7d9f9AZUmAbdJW8aGM67BFtwh9UCR489y86nLYTssKF
 UN1J41lsTDSU2WVxWIH40_4RJqeHhSyHQG2Cev36LWMWAfSUvIBbJBZ12TKodAeFK.oMncSsa8MA
 hN7ClBhRgKwM6uJ7GJGb5QvoUmUkZYYkgDYptlT52rYoslsDdIahb3n.eY1F1NqeD61RKTAsBOSB
 ReWHF71nKGwWPLq6wcOSGEjUds.E71F2T_6S1gNKmSPYLt2uKS7uoWBffwZD_rrTLmHH969KvMVN
 OWhLSFCMn4EieufyH_sNMW96rCWFlDISlMYV6TLDup24ZsXXdfIP9llEoL8jchINuMcAt5KcFhqw
 ghOIOOxj1wqvyWc6ssdZtJ_gsRkijsylFebQYMKtkcsAbQVWhSqpG2tmIFipSW.BVCSAAB80sM7M
 NQGhJQ6ON8ifCD2LU90Dqtel_P9Sy65lLYU0uHsPM8POIbi1MH2IqMVsJwiFAE4qwPD2x0WwZx_S
 TDBSGz9fX7cRMClzD.3mkU6XlYoen4zLBxZRAd8x3tKxfYE.ZFwMbqEMpdnbxljkMDA--
X-Sonic-MF: <pheonix.sja@att.net>
X-Sonic-ID: 6d6832f6-351d-4477-85fa-b21147034f07
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 8 May 2025 18:42:50 +0000
Received: by hermes--production-bf1-689c4795f-t7r8f (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 14468c287028ed6724a5eeaaf9d4edd3;
          Thu, 08 May 2025 18:42:45 +0000 (UTC)
Date: Thu, 08 May 2025 14:42:37 -0400
From: Steven J Abner <pheonix.sja@att.net>
Subject: Re: Kernels >= 6.3 disable video output
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org
Message-Id: <1BHYVS.FW7S9BTTF682@att.net>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
References: <1BHYVS.FW7S9BTTF682.ref@att.net>

 > one from a working boot, and one from where the screen stayed blank.

AMD 2400g, Zen1, 'Raven' firmware, igpu, no card.
Hopefully you wanted lasted kernel, and not the differences of 6.2 vs. 
6.3.
These are done from booted into kernels, outputs from dmesg > 
<file_on/off>.
Could have accessed logs but felt this would show both "consoles" 
functioning.
Added note: Only other than basic software is Xorg, and just added gdb. 
But this bug found even prior to inclusion of those.
 Firstly "off":
[ 0.000000] Linux version 6.13.4 (root@steven-ryzen) (gcc (GCC) 14.2.0, 
GNU ld (GNU Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Thu May 8 13:55:46 
EDT 2025
[ 0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.13.4-lfs-12.3 
root=/dev/nvme0n1p5 ro
[ 0.000000] BIOS-provided physical RAM map:
[ 0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] 
usable
[ 0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] 
reserved
[ 0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009d01fff] 
usable
[ 0.000000] BIOS-e820: [mem 0x0000000009d02000-0x0000000009ffffff] 
reserved
[ 0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff] 
usable
[ 0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a20afff] ACPI 
NVS
[ 0.000000] BIOS-e820: [mem 0x000000000a20b000-0x000000000affffff] 
usable
[ 0.000000] BIOS-e820: [mem 0x000000000b000000-0x000000000b01ffff] 
reserved
[ 0.000000] BIOS-e820: [mem 0x000000000b020000-0x000000005aed0fff] 
usable
[ 0.000000] BIOS-e820: [mem 0x000000005aed1000-0x000000005c3affff] 
reserved
[ 0.000000] BIOS-e820: [mem 0x000000005c3b0000-0x000000005c42cfff] ACPI 
data
[ 0.000000] BIOS-e820: [mem 0x000000005c42d000-0x000000005c93efff] ACPI 
NVS
[ 0.000000] BIOS-e820: [mem 0x000000005c93f000-0x000000005d75efff] 
reserved
[ 0.000000] BIOS-e820: [mem 0x000000005d75f000-0x000000005effffff] 
usable
[ 0.000000] BIOS-e820: [mem 0x000000005f000000-0x00000000dfffffff] 
reserved
[ 0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] 
reserved
[ 0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000ffffffff] 
reserved
[ 0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000021f33ffff] 
usable
[ 0.000000] NX (Execute Disable) protection: active
[ 0.000000] APIC: Static calls initialized
[ 0.000000] e820: update [mem 0x57082018-0x5708f457] usable ==> usable
[ 0.000000] extended physical RAM map:
[ 0.000000] reserve setup_data: [mem 
0x0000000000000000-0x000000000009ffff] usable
[ 0.000000] reserve setup_data: [mem 
0x00000000000a0000-0x00000000000fffff] reserved
[ 0.000000] reserve setup_data: [mem 
0x0000000000100000-0x0000000009d01fff] usable
[ 0.000000] reserve setup_data: [mem 
0x0000000009d02000-0x0000000009ffffff] reserved
[ 0.000000] reserve setup_data: [mem 
0x000000000a000000-0x000000000a1fffff] usable
[ 0.000000] reserve setup_data: [mem 
0x000000000a200000-0x000000000a20afff] ACPI NVS
[ 0.000000] reserve setup_data: [mem 
0x000000000a20b000-0x000000000affffff] usable
[ 0.000000] reserve setup_data: [mem 
0x000000000b000000-0x000000000b01ffff] reserved
[ 0.000000] reserve setup_data: [mem 
0x000000000b020000-0x0000000057082017] usable
[ 0.000000] reserve setup_data: [mem 
0x0000000057082018-0x000000005708f457] usable
[ 0.000000] reserve setup_data: [mem 
0x000000005708f458-0x000000005aed0fff] usable
[ 0.000000] reserve setup_data: [mem 
0x000000005aed1000-0x000000005c3affff] reserved
[ 0.000000] reserve setup_data: [mem 
0x000000005c3b0000-0x000000005c42cfff] ACPI data
[ 0.000000] reserve setup_data: [mem 
0x000000005c42d000-0x000000005c93efff] ACPI NVS
[ 0.000000] reserve setup_data: [mem 
0x000000005c93f000-0x000000005d75efff] reserved
[ 0.000000] reserve setup_data: [mem 
0x000000005d75f000-0x000000005effffff] usable
[ 0.000000] reserve setup_data: [mem 
0x000000005f000000-0x00000000dfffffff] reserved
[ 0.000000] reserve setup_data: [mem 
0x00000000f8000000-0x00000000fbffffff] reserved
[ 0.000000] reserve setup_data: [mem 
0x00000000fd000000-0x00000000ffffffff] reserved
[ 0.000000] reserve setup_data: [mem 
0x0000000100000000-0x000000021f33ffff] usable
[ 0.000000] efi: EFI v2.7 by American Megatrends
[ 0.000000] efi: ACPI 2.0=0x5c8bb000 ACPI=0x5c8bb000 SMBIOS=0x5d593000 
SMBIOS 3.0=0x5d592000 MEMATTR=0x577e2018 ESRT=0x5719ab98 RNG=0x5c42c018
[ 0.000000] random: crng init done
[ 0.000000] efi: Remove mem269: MMIO range=[0xf8000000-0xfbffffff] 
(64MB) from e820 map
[ 0.000000] e820: remove [mem 0xf8000000-0xfbffffff] reserved
[ 0.000000] efi: Remove mem270: MMIO range=[0xfd000000-0xffffffff] 
(48MB) from e820 map
[ 0.000000] e820: remove [mem 0xfd000000-0xffffffff] reserved
[ 0.000000] SMBIOS 3.2.1 present.
[ 0.000000] DMI: To Be Filled By O.E.M. To Be Filled By O.E.M./B450 
Gaming-ITX/ac, BIOS P3.40 07/17/2019
[ 0.000000] DMI: Memory slots populated: 2/2
[ 0.000000] tsc: Fast TSC calibration using PIT
[ 0.000000] tsc: Detected 3900.322 MHz processor
[ 0.000452] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[ 0.000454] e820: remove [mem 0x000a0000-0x000fffff] usable
[ 0.000460] last_pfn = 0x21f340 max_arch_pfn = 0x400000000
[ 0.000464] MTRR map: 5 entries (3 fixed + 2 variable; max 20), built 
from 9 variable MTRRs
[ 0.000465] x86/PAT: Configuration [0-7]: WB WC UC- UC WB WP UC- WT
[ 0.000592] e820: update [mem 0xe0000000-0xffffffff] usable ==> reserved
[ 0.000610] last_pfn = 0x5f000 max_arch_pfn = 0x400000000
[ 0.003959] esrt: Reserving ESRT space from 0x000000005719ab98 to 
0x000000005719abd0.
[ 0.003969] e820: update [mem 0x5719a000-0x5719afff] usable ==> reserved
[ 0.004001] Using GB pages for direct mapping
[ 0.004592] Secure boot disabled
[ 0.004594] ACPI: Early table checksum verification disabled
[ 0.004596] ACPI: RSDP 0x000000005C8BB000 000024 (v02 ALASKA)
[ 0.004599] ACPI: XSDT 0x000000005C8BB0A0 0000BC (v01 ALASKA A M I 
01072009 AMI 00010013)
[ 0.004603] ACPI: FACP 0x000000005C8C1BB8 000114 (v06 ALASKA A M I 
01072009 AMI 00010013)
[ 0.004606] ACPI: DSDT 0x000000005C8BB1F0 0069C1 (v02 ALASKA A M I 
01072009 INTL 20120913)
[ 0.004609] ACPI: FACS 0x000000005C927E00 000040
[ 0.004610] ACPI: APIC 0x000000005C8C1CD0 00015E (v03 ALASKA A M I 
01072009 AMI 00010013)
[ 0.004612] ACPI: FPDT 0x000000005C8C1E30 000044 (v01 ALASKA A M I 
01072009 AMI 00010013)
[ 0.004614] ACPI: FIDT 0x000000005C8C1E78 00009C (v01 ALASKA A M I 
01072009 AMI 00010013)
[ 0.004616] ACPI: SSDT 0x000000005C8C1F18 000094 (v02 ALASKA CPUSSDT 
01072009 AMI 01072009)
[ 0.004618] ACPI: SSDT 0x000000005C8C1FB0 005419 (v02 AMD AmdTable 
00000002 MSFT 02000002)
[ 0.004620] ACPI: SSDT 0x000000005C8C73D0 00315B (v01 AMD AMD AOD 
00000001 INTL 20120913)
[ 0.004622] ACPI: MCFG 0x000000005C8CA530 00003C (v01 ALASKA A M I 
01072009 MSFT 00010013)
[ 0.004623] ACPI: AAFT 0x000000005C8CA570 000440 (v01 ALASKA OEMAAFT 
01072009 MSFT 00000097)
[ 0.004625] ACPI: HPET 0x000000005C8CA9B0 000038 (v01 ALASKA A M I 
01072009 AMI 00000005)
[ 0.004627] ACPI: UEFI 0x000000005C8CA9E8 000042 (v01 ALASKA A M I 
00000002 01000013)
[ 0.004629] ACPI: BGRT 0x000000005C8CAA30 000038 (v01 ALASKA A M I 
01072009 AMI 00010013)
[ 0.004631] ACPI: SSDT 0x000000005C8CAA68 000E0C (v01 AMD AMD CPU 
00000001 AMD 00000001)
[ 0.004632] ACPI: CRAT 0x000000005C8CB878 000810 (v01 AMD AMD CRAT 
00000001 AMD 00000001)
[ 0.004634] ACPI: CDIT 0x000000005C8CC088 000029 (v01 AMD AMD CDIT 
00000001 AMD 00000001)
[ 0.004636] ACPI: SSDT 0x000000005C8CC0B8 001D34 (v01 AMD AmdTable 
00000001 INTL 20120913)
[ 0.004638] ACPI: SSDT 0x000000005C8CDDF0 0000BF (v01 AMD AMD PT 
00001000 INTL 20120913)
[ 0.004640] ACPI: WSMT 0x000000005C8CDEB0 000028 (v01 ALASKA A M I 
01072009 AMI 00010013)
[ 0.004641] ACPI: SSDT 0x000000005C8CDED8 0010AF (v01 AMD AmdTable 
00000001 INTL 20120913)
[ 0.004643] ACPI: Reserving FACP table memory at [mem 
0x5c8c1bb8-0x5c8c1ccb]
[ 0.004644] ACPI: Reserving DSDT table memory at [mem 
0x5c8bb1f0-0x5c8c1bb0]
[ 0.004645] ACPI: Reserving FACS table memory at [mem 
0x5c927e00-0x5c927e3f]
[ 0.004645] ACPI: Reserving APIC table memory at [mem 
0x5c8c1cd0-0x5c8c1e2d]
[ 0.004646] ACPI: Reserving FPDT table memory at [mem 
0x5c8c1e30-0x5c8c1e73]
[ 0.004647] ACPI: Reserving FIDT table memory at [mem 
0x5c8c1e78-0x5c8c1f13]
[ 0.004647] ACPI: Reserving SSDT table memory at [mem 
0x5c8c1f18-0x5c8c1fab]
[ 0.004648] ACPI: Reserving SSDT table memory at [mem 
0x5c8c1fb0-0x5c8c73c8]
[ 0.004649] ACPI: Reserving SSDT table memory at [mem 
0x5c8c73d0-0x5c8ca52a]
[ 0.004649] ACPI: Reserving MCFG table memory at [mem 
0x5c8ca530-0x5c8ca56b]
[ 0.004650] ACPI: Reserving AAFT table memory at [mem 
0x5c8ca570-0x5c8ca9af]
[ 0.004650] ACPI: Reserving HPET table memory at [mem 
0x5c8ca9b0-0x5c8ca9e7]
[ 0.004651] ACPI: Reserving UEFI table memory at [mem 
0x5c8ca9e8-0x5c8caa29]
[ 0.004652] ACPI: Reserving BGRT table memory at [mem 
0x5c8caa30-0x5c8caa67]
[ 0.004652] ACPI: Reserving SSDT table memory at [mem 
0x5c8caa68-0x5c8cb873]
[ 0.004653] ACPI: Reserving CRAT table memory at [mem 
0x5c8cb878-0x5c8cc087]
[ 0.004654] ACPI: Reserving CDIT table memory at [mem 
0x5c8cc088-0x5c8cc0b0]
[ 0.004654] ACPI: Reserving SSDT table memory at [mem 
0x5c8cc0b8-0x5c8cddeb]
[ 0.004655] ACPI: Reserving SSDT table memory at [mem 
0x5c8cddf0-0x5c8cdeae]
[ 0.004655] ACPI: Reserving WSMT table memory at [mem 
0x5c8cdeb0-0x5c8cded7]
[ 0.004656] ACPI: Reserving SSDT table memory at [mem 
0x5c8cded8-0x5c8cef86]
[ 0.004731] No NUMA configuration found
[ 0.004732] Faking a node at [mem 0x0000000000000000-0x000000021f33ffff]
[ 0.004734] NODE_DATA(0) allocated [mem 0x21f33c940-0x21f33ffff]
[ 0.004747] Zone ranges:
[ 0.004747] DMA [mem 0x0000000000001000-0x0000000000ffffff]
[ 0.004748] DMA32 [mem 0x0000000001000000-0x00000000ffffffff]
[ 0.004749] Normal [mem 0x0000000100000000-0x000000021f33ffff]
[ 0.004750] Movable zone start for each node
[ 0.004750] Early memory node ranges
[ 0.004751] node 0: [mem 0x0000000000001000-0x000000000009ffff]
[ 0.004752] node 0: [mem 0x0000000000100000-0x0000000009d01fff]
[ 0.004753] node 0: [mem 0x000000000a000000-0x000000000a1fffff]
[ 0.004753] node 0: [mem 0x000000000a20b000-0x000000000affffff]
[ 0.004754] node 0: [mem 0x000000000b020000-0x000000005aed0fff]
[ 0.004755] node 0: [mem 0x000000005d75f000-0x000000005effffff]
[ 0.004755] node 0: [mem 0x0000000100000000-0x000000021f33ffff]
[ 0.004756] Initmem setup node 0 [mem 
0x0000000000001000-0x000000021f33ffff]
[ 0.004760] On node 0, zone DMA: 1 pages in unavailable ranges
[ 0.004780] On node 0, zone DMA: 96 pages in unavailable ranges
[ 0.004963] On node 0, zone DMA32: 766 pages in unavailable ranges
[ 0.004981] On node 0, zone DMA32: 11 pages in unavailable ranges
[ 0.006979] On node 0, zone DMA32: 32 pages in unavailable ranges
[ 0.007116] On node 0, zone DMA32: 10382 pages in unavailable ranges
[ 0.014382] On node 0, zone Normal: 4096 pages in unavailable ranges
[ 0.014415] On node 0, zone Normal: 3264 pages in unavailable ranges
[ 0.015220] ACPI: PM-Timer IO Port: 0x808
[ 0.015226] CPU topo: Ignoring hot-pluggable APIC ID 0 in present 
package.
[ 0.015229] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[ 0.015248] IOAPIC[0]: apic_id 9, version 33, address 0xfec00000, GSI 
0-23
[ 0.015259] IOAPIC[1]: apic_id 10, version 33, address 0xfec01000, GSI 
24-55
[ 0.015260] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[ 0.015262] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[ 0.015264] ACPI: Using ACPI (MADT) for SMP configuration information
[ 0.015265] ACPI: HPET id: 0x10228201 base: 0xfed00000
[ 0.015278] e820: update [mem 0x57754000-0x57794fff] usable ==> reserved
[ 0.015291] CPU topo: Max. logical packages: 1
[ 0.015291] CPU topo: Max. logical dies: 1
[ 0.015292] CPU topo: Max. dies per package: 1
[ 0.015295] CPU topo: Max. threads per core: 2
[ 0.015296] CPU topo: Num. cores per package: 4
[ 0.015296] CPU topo: Num. threads per package: 8
[ 0.015297] CPU topo: Allowing 8 present CPUs plus 0 hotplug CPUs
[ 0.015297] CPU topo: Rejected CPUs 24
[ 0.015309] PM: hibernation: Registered nosave memory: [mem 
0x00000000-0x00000fff]
[ 0.015311] PM: hibernation: Registered nosave memory: [mem 
0x000a0000-0x000fffff]
[ 0.015312] PM: hibernation: Registered nosave memory: [mem 
0x09d02000-0x09ffffff]
[ 0.015313] PM: hibernation: Registered nosave memory: [mem 
0x0a200000-0x0a20afff]
[ 0.015314] PM: hibernation: Registered nosave memory: [mem 
0x0b000000-0x0b01ffff]
[ 0.015315] PM: hibernation: Registered nosave memory: [mem 
0x57082000-0x57082fff]
[ 0.015316] PM: hibernation: Registered nosave memory: [mem 
0x5708f000-0x5708ffff]
[ 0.015318] PM: hibernation: Registered nosave memory: [mem 
0x5719a000-0x5719afff]
[ 0.015319] PM: hibernation: Registered nosave memory: [mem 
0x57754000-0x57794fff]
[ 0.015320] PM: hibernation: Registered nosave memory: [mem 
0x5aed1000-0x5c3affff]
[ 0.015321] PM: hibernation: Registered nosave memory: [mem 
0x5c3b0000-0x5c42cfff]
[ 0.015321] PM: hibernation: Registered nosave memory: [mem 
0x5c42d000-0x5c93efff]
[ 0.015322] PM: hibernation: Registered nosave memory: [mem 
0x5c93f000-0x5d75efff]
[ 0.015323] PM: hibernation: Registered nosave memory: [mem 
0x5f000000-0xdfffffff]
[ 0.015323] PM: hibernation: Registered nosave memory: [mem 
0xe0000000-0xffffffff]
[ 0.015324] [mem 0xe0000000-0xffffffff] available for PCI devices
[ 0.015327] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 1910969940391419 ns
[ 0.021420] setup_percpu: NR_CPUS:64 nr_cpumask_bits:8 nr_cpu_ids:8 
nr_node_ids:1
[ 0.021669] percpu: Embedded 56 pages/cpu s191256 r8192 d29928 u262144
[ 0.021674] pcpu-alloc: s191256 r8192 d29928 u262144 alloc=1*2097152
[ 0.021676] pcpu-alloc: [0] 0 1 2 3 4 5 6 7
[ 0.021689] Kernel command line: 
BOOT_IMAGE=/boot/vmlinuz-6.13.4-lfs-12.3 root=/dev/nvme0n1p5 ro
[ 0.021709] Unknown kernel command line parameters 
"BOOT_IMAGE=/boot/vmlinuz-6.13.4-lfs-12.3", will be passed to user 
space.
[ 0.021936] printk: log buffer data + meta data: 262144 + 917504 = 
1179648 bytes
[ 0.022620] Dentry cache hash table entries: 1048576 (order: 11, 
8388608 bytes, linear)
[ 0.023001] Inode-cache hash table entries: 524288 (order: 10, 4194304 
bytes, linear)
[ 0.023044] Fallback order for Node 0: 0
[ 0.023047] Built 1 zonelists, mobility grouping on. Total pages: 
1554216
[ 0.023049] Policy zone: Normal
[ 0.023050] mem auto-init: stack:all(zero), heap alloc:off, heap 
free:off
[ 0.023053] software IO TLB: area num 8.
[ 0.043347] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[ 0.044104] Dynamic Preempt: voluntary
[ 0.044133] rcu: Preemptible hierarchical RCU implementation.
[ 0.044133] rcu: RCU event tracing is enabled.
[ 0.044133] rcu: RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=8.
[ 0.044135] Trampoline variant of Tasks RCU enabled.
[ 0.044135] Tracing variant of Tasks RCU enabled.
[ 0.044136] rcu: RCU calculated value of scheduler-enlistment delay is 
100 jiffies.
[ 0.044136] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[ 0.044142] RCU Tasks: Setting shift to 3 and lim to 1 
rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
[ 0.044144] RCU Tasks Trace: Setting shift to 3 and lim to 1 
rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
[ 0.047176] NR_IRQS: 4352, nr_irqs: 1032, preallocated irqs: 16
[ 0.047372] rcu: srcu_init: Setting srcu_struct sizes based on 
contention.
[ 0.047517] Console: colour dummy device 80x25
[ 0.047519] printk: legacy console [tty0] enabled
[ 0.047802] ACPI: Core revision 20240827
[ 0.047900] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, 
max_idle_ns: 133484873504 ns
[ 0.047932] APIC: Switch to symmetric I/O mode setup
[ 0.049296] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[ 0.053936] clocksource: tsc-early: mask: 0xffffffffffffffff 
max_cycles: 0x70711397055, max_idle_ns: 881590636608 ns
[ 0.053942] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 7800.64 BogoMIPS (lpj=3900322)
[ 0.053953] AMD Zen1 DIV0 bug detected. Disable SMT for full protection.
[ 0.054076] LVT offset 1 assigned for vector 0xf9
[ 0.054115] LVT offset 2 assigned for vector 0xf4
[ 0.054128] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[ 0.054130] Last level dTLB entries: 4KB 1536, 2MB 1536, 4MB 768, 1GB 0
[ 0.054134] process: using mwait in idle threads
[ 0.054136] Spectre V1 : Mitigation: usercopy/swapgs barriers and 
__user pointer sanitization
[ 0.054139] Spectre V2 : Mitigation: Retpolines
[ 0.054141] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling 
RSB on context switch
[ 0.054143] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[ 0.054145] Spectre V2 : Enabling Speculation Barrier for firmware calls
[ 0.054147] RETBleed: Mitigation: untrained return thunk
[ 0.054149] Spectre V2 : mitigation: Enabling conditional Indirect 
Branch Prediction Barrier
[ 0.054152] Speculative Store Bypass: Mitigation: Speculative Store 
Bypass disabled via prctl
[ 0.054155] Speculative Return Stack Overflow: Mitigation: Safe RET
[ 0.054159] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating 
point registers'
[ 0.054162] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[ 0.054164] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[ 0.054166] x86/fpu: xstate_offset[2]: 576, xstate_sizes[2]: 256
[ 0.054169] x86/fpu: Enabled xstate features 0x7, context size is 832 
bytes, using 'compacted' format.
[ 0.074344] Freeing SMP alternatives memory: 44K
[ 0.074353] pid_max: default: 32768 minimum: 301
[ 0.076970] LSM: initializing lsm=capability,selinux
[ 0.077000] SELinux: Initializing.
[ 0.077199] Mount-cache hash table entries: 16384 (order: 5, 131072 
bytes, linear)
[ 0.077214] Mountpoint-cache hash table entries: 16384 (order: 5, 
131072 bytes, linear)
[ 0.180586] smpboot: CPU0: AMD Ryzen 5 2400G with Radeon Vega Graphics 
(family: 0x17, model: 0x11, stepping: 0x0)
[ 0.180786] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[ 0.180812] ... version: 0
[ 0.180816] ... bit width: 48
[ 0.180820] ... generic registers: 6
[ 0.180824] ... value mask: 0000ffffffffffff
[ 0.180829] ... max period: 00007fffffffffff
[ 0.180833] ... fixed-purpose events: 0
[ 0.180837] ... event mask: 000000000000003f
[ 0.180929] signal: max sigframe size: 1776
[ 0.180940] rcu: Hierarchical SRCU implementation.
[ 0.180940] rcu: Max phase no-delay instances is 400.
[ 0.180940] Timer migration: 1 hierarchy levels; 8 children per group; 
1 crossnode level
[ 0.184929] smp: Bringing up secondary CPUs ...
[ 0.185027] smpboot: x86: Booting SMP configuration:
[ 0.185032] .... node #0, CPUs: #1 #2 #3 #4 #5 #6 #7
[ 0.193955] smp: Brought up 1 node, 8 CPUs
[ 0.193965] smpboot: Total of 8 processors activated (62405.15 BogoMIPS)
[ 0.194687] Memory: 5982600K/6216864K available (22528K kernel code, 
3041K rwdata, 11360K rodata, 2932K init, 1880K bss, 228952K reserved, 
0K cma-reserved)
[ 0.195194] devtmpfs: initialized
[ 0.195454] ACPI: PM: Registering ACPI NVS region [mem 
0x0a200000-0x0a20afff] (45056 bytes)
[ 0.195454] ACPI: PM: Registering ACPI NVS region [mem 
0x5c42d000-0x5c93efff] (5316608 bytes)
[ 0.195950] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 1911260446275000 ns
[ 0.195960] futex hash table entries: 2048 (order: 5, 131072 bytes, 
linear)
[ 0.195993] pinctrl core: initialized pinctrl subsystem
[ 0.196062] PM: RTC time: 18:05:18, date: 2025-05-08
[ 0.196149] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[ 0.196300] audit: initializing netlink subsys (disabled)
[ 0.196311] audit: type=2000 audit(1746727518.000:1): state=initialized 
audit_enabled=0 res=1
[ 0.196311] thermal_sys: Registered thermal governor 'step_wise'
[ 0.196311] thermal_sys: Registered thermal governor 'user_space'
[ 0.196311] cpuidle: using governor menu
[ 0.196311] PCI: ECAM [mem 0xf8000000-0xfbffffff] (base 0xf8000000) for 
domain 0000 [bus 00-3f]
[ 0.196311] PCI: Using configuration type 1 for base access
[ 0.196311] kprobes: kprobe jump-optimization is enabled. All kprobes 
are optimized if possible.
[ 0.196311] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 
pages
[ 0.196311] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[ 0.197001] ACPI: Added _OSI(Module Device)
[ 0.197006] ACPI: Added _OSI(Processor Device)
[ 0.197011] ACPI: Added _OSI(3.0 _SCP Extensions)
[ 0.197016] ACPI: Added _OSI(Processor Aggregator Device)
[ 0.206756] ACPI: 8 ACPI AML tables successfully acquired and loaded
[ 0.208580] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[ 0.211744] ACPI: Interpreter enabled
[ 0.211744] ACPI: PM: (supports S0 S3 S4 S5)
[ 0.211744] ACPI: Using IOAPIC for interrupt routing
[ 0.212179] PCI: Using host bridge windows from ACPI; if necessary, use 
"pci=nocrs" and report a bug
[ 0.212187] PCI: Using E820 reservations for host bridge windows
[ 0.212588] ACPI: Enabled 2 GPEs in block 00 to 1F
[ 0.224477] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[ 0.224488] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM 
ClockPM Segments MSI HPX-Type3]
[ 0.224585] acpi PNP0A08:00: _OSC: platform does not support [LTR]
[ 0.224757] acpi PNP0A08:00: _OSC: OS now controls [PME PCIeCapability]
[ 0.224770] acpi PNP0A08:00: [Firmware Info]: ECAM [mem 
0xf8000000-0xfbffffff] for domain 0000 [bus 00-3f] only partially 
covers this bridge
[ 0.225110] PCI host bridge to bus 0000:00
[ 0.225117] pci_bus 0000:00: root bus resource [io 0x0000-0x03af window]
[ 0.225124] pci_bus 0000:00: root bus resource [io 0x03e0-0x0cf7 window]
[ 0.225131] pci_bus 0000:00: root bus resource [io 0x03b0-0x03df window]
[ 0.225137] pci_bus 0000:00: root bus resource [io 0x0d00-0xffff window]
[ 0.225144] pci_bus 0000:00: root bus resource [mem 
0x000a0000-0x000dffff window]
[ 0.225151] pci_bus 0000:00: root bus resource [mem 
0xe0000000-0xfec2ffff window]
[ 0.225158] pci_bus 0000:00: root bus resource [mem 
0xfee00000-0xffffffff window]
[ 0.225165] pci_bus 0000:00: root bus resource [bus 00-ff]
[ 0.225187] pci 0000:00:00.0: [1022:15d0] type 00 class 0x060000 
conventional PCI endpoint
[ 0.225349] pci 0000:00:01.0: [1022:1452] type 00 class 0x060000 
conventional PCI endpoint
[ 0.225468] pci 0000:00:01.1: [1022:15d3] type 01 class 0x060400 PCIe 
Root Port
[ 0.225505] pci 0000:00:01.1: PCI bridge to [bus 01-04]
[ 0.225518] pci 0000:00:01.1: bridge window [mem 0xfc200000-0xfc5fffff]
[ 0.225545] pci 0000:00:01.1: enabling Extended Tags
[ 0.225623] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[ 0.225860] pci 0000:00:01.2: [1022:15d3] type 01 class 0x060400 PCIe 
Root Port
[ 0.225897] pci 0000:00:01.2: PCI bridge to [bus 05-0c]
[ 0.225908] pci 0000:00:01.2: bridge window [io 0xf000-0xffff]
[ 0.225916] pci 0000:00:01.2: bridge window [mem 0xfca00000-0xfccfffff]
[ 0.225945] pci 0000:00:01.2: enabling Extended Tags
[ 0.226024] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[ 0.226289] pci 0000:00:01.6: [1022:15d3] type 01 class 0x060400 PCIe 
Root Port
[ 0.226326] pci 0000:00:01.6: PCI bridge to [bus 0d]
[ 0.226339] pci 0000:00:01.6: bridge window [mem 0xfce00000-0xfcefffff]
[ 0.226365] pci 0000:00:01.6: enabling Extended Tags
[ 0.226443] pci 0000:00:01.6: PME# supported from D0 D3hot D3cold
[ 0.226668] pci 0000:00:08.0: [1022:1452] type 00 class 0x060000 
conventional PCI endpoint
[ 0.226793] pci 0000:00:08.1: [1022:15db] type 01 class 0x060400 PCIe 
Root Port
[ 0.226833] pci 0000:00:08.1: PCI bridge to [bus 0e]
[ 0.226844] pci 0000:00:08.1: bridge window [io 0xe000-0xefff]
[ 0.226853] pci 0000:00:08.1: bridge window [mem 0xfc600000-0xfc9fffff]
[ 0.226869] pci 0000:00:08.1: bridge window [mem 0xe0000000-0xf01fffff 
64bit pref]
[ 0.226887] pci 0000:00:08.1: enabling Extended Tags
[ 0.226963] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[ 0.227211] pci 0000:00:08.2: [1022:15dc] type 01 class 0x060400 PCIe 
Root Port
[ 0.227251] pci 0000:00:08.2: PCI bridge to [bus 0f]
[ 0.227265] pci 0000:00:08.2: bridge window [mem 0xfcd00000-0xfcdfffff]
[ 0.227292] pci 0000:00:08.2: enabling Extended Tags
[ 0.227371] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
[ 0.227633] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 
conventional PCI endpoint
[ 0.227836] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 
conventional PCI endpoint
[ 0.228049] pci 0000:00:18.0: [1022:15e8] type 00 class 0x060000 
conventional PCI endpoint
[ 0.228102] pci 0000:00:18.1: [1022:15e9] type 00 class 0x060000 
conventional PCI endpoint
[ 0.228154] pci 0000:00:18.2: [1022:15ea] type 00 class 0x060000 
conventional PCI endpoint
[ 0.228208] pci 0000:00:18.3: [1022:15eb] type 00 class 0x060000 
conventional PCI endpoint
[ 0.228260] pci 0000:00:18.4: [1022:15ec] type 00 class 0x060000 
conventional PCI endpoint
[ 0.228311] pci 0000:00:18.5: [1022:15ed] type 00 class 0x060000 
conventional PCI endpoint
[ 0.228363] pci 0000:00:18.6: [1022:15ee] type 00 class 0x060000 
conventional PCI endpoint
[ 0.228415] pci 0000:00:18.7: [1022:15ef] type 00 class 0x060000 
conventional PCI endpoint
[ 0.228546] pci 0000:01:00.0: [12d8:2304] type 01 class 0x060400 PCIe 
Switch Upstream Port
[ 0.228586] pci 0000:01:00.0: PCI bridge to [bus 02-04]
[ 0.228600] pci 0000:01:00.0: bridge window [mem 0xfc200000-0xfc5fffff]
[ 0.228718] pci 0000:01:00.0: supports D1 D2
[ 0.228723] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[ 0.228767] pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, 
limited by 5.0 GT/s PCIe x1 link at 0000:00:01.1 (capable of 8.000 Gb/s 
with 5.0 GT/s PCIe x2 link)
[ 0.228896] pci 0000:00:01.1: PCI bridge to [bus 01-04]
[ 0.228987] pci 0000:02:01.0: [12d8:2304] type 01 class 0x060400 PCIe 
Switch Downstream Port
[ 0.229027] pci 0000:02:01.0: PCI bridge to [bus 03]
[ 0.229040] pci 0000:02:01.0: bridge window [mem 0xfc400000-0xfc5fffff]
[ 0.229158] pci 0000:02:01.0: supports D1 D2
[ 0.229163] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[ 0.229311] pci 0000:02:02.0: [12d8:2304] type 01 class 0x060400 PCIe 
Switch Downstream Port
[ 0.229351] pci 0000:02:02.0: PCI bridge to [bus 04]
[ 0.229365] pci 0000:02:02.0: bridge window [mem 0xfc200000-0xfc3fffff]
[ 0.229482] pci 0000:02:02.0: supports D1 D2
[ 0.229487] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[ 0.229647] pci 0000:01:00.0: PCI bridge to [bus 02-04]
[ 0.229739] pci 0000:03:00.0: [14f1:8880] type 00 class 0x040000 PCIe 
Endpoint
[ 0.229779] pci 0000:03:00.0: BAR 0 [mem 0xfc400000-0xfc5fffff 64bit]
[ 0.229972] pci 0000:03:00.0: supports D1 D2
[ 0.229977] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[ 0.230124] pci 0000:02:01.0: PCI bridge to [bus 03]
[ 0.230218] pci 0000:04:00.0: [14f1:8880] type 00 class 0x040000 PCIe 
Endpoint
[ 0.230259] pci 0000:04:00.0: BAR 0 [mem 0xfc200000-0xfc3fffff 64bit]
[ 0.230449] pci 0000:04:00.0: supports D1 D2
[ 0.230454] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[ 0.230600] pci 0000:02:02.0: PCI bridge to [bus 04]
[ 0.230707] pci 0000:05:00.0: [1022:43d5] type 00 class 0x0c0330 PCIe 
Legacy Endpoint
[ 0.230735] pci 0000:05:00.0: BAR 0 [mem 0xfcca0000-0xfcca7fff 64bit]
[ 0.230789] pci 0000:05:00.0: enabling Extended Tags
[ 0.230865] pci 0000:05:00.0: PME# supported from D3hot D3cold
[ 0.231045] pci 0000:05:00.1: [1022:43c8] type 00 class 0x010601 PCIe 
Legacy Endpoint
[ 0.231110] pci 0000:05:00.1: BAR 5 [mem 0xfcc80000-0xfcc9ffff]
[ 0.231124] pci 0000:05:00.1: ROM [mem 0xfcc00000-0xfcc7ffff pref]
[ 0.231137] pci 0000:05:00.1: enabling Extended Tags
[ 0.231193] pci 0000:05:00.1: PME# supported from D3hot D3cold
[ 0.231316] pci 0000:05:00.2: [1022:43c6] type 01 class 0x060400 PCIe 
Switch Upstream Port
[ 0.231357] pci 0000:05:00.2: PCI bridge to [bus 06-0c]
[ 0.231368] pci 0000:05:00.2: bridge window [io 0xf000-0xffff]
[ 0.231376] pci 0000:05:00.2: bridge window [mem 0xfca00000-0xfcbfffff]
[ 0.231407] pci 0000:05:00.2: enabling Extended Tags
[ 0.231469] pci 0000:05:00.2: PME# supported from D3hot D3cold
[ 0.231642] pci 0000:00:01.2: PCI bridge to [bus 05-0c]
[ 0.231721] pci 0000:06:00.0: [1022:43c7] type 01 class 0x060400 PCIe 
Switch Downstream Port
[ 0.231763] pci 0000:06:00.0: PCI bridge to [bus 07]
[ 0.231803] pci 0000:06:00.0: enabling Extended Tags
[ 0.231886] pci 0000:06:00.0: PME# supported from D3hot D3cold
[ 0.232037] pci 0000:06:01.0: [1022:43c7] type 01 class 0x060400 PCIe 
Switch Downstream Port
[ 0.232080] pci 0000:06:01.0: PCI bridge to [bus 08]
[ 0.232120] pci 0000:06:01.0: enabling Extended Tags
[ 0.232203] pci 0000:06:01.0: PME# supported from D3hot D3cold
[ 0.232353] pci 0000:06:04.0: [1022:43c7] type 01 class 0x060400 PCIe 
Switch Downstream Port
[ 0.232395] pci 0000:06:04.0: PCI bridge to [bus 09]
[ 0.232436] pci 0000:06:04.0: enabling Extended Tags
[ 0.232518] pci 0000:06:04.0: PME# supported from D3hot D3cold
[ 0.232667] pci 0000:06:05.0: [1022:43c7] type 01 class 0x060400 PCIe 
Switch Downstream Port
[ 0.232709] pci 0000:06:05.0: PCI bridge to [bus 0a]
[ 0.232750] pci 0000:06:05.0: enabling Extended Tags
[ 0.232832] pci 0000:06:05.0: PME# supported from D3hot D3cold
[ 0.232983] pci 0000:06:06.0: [1022:43c7] type 01 class 0x060400 PCIe 
Switch Downstream Port
[ 0.233025] pci 0000:06:06.0: PCI bridge to [bus 0b]
[ 0.233039] pci 0000:06:06.0: bridge window [mem 0xfcb00000-0xfcbfffff]
[ 0.233072] pci 0000:06:06.0: enabling Extended Tags
[ 0.233155] pci 0000:06:06.0: PME# supported from D3hot D3cold
[ 0.233306] pci 0000:06:07.0: [1022:43c7] type 01 class 0x060400 PCIe 
Switch Downstream Port
[ 0.233348] pci 0000:06:07.0: PCI bridge to [bus 0c]
[ 0.233359] pci 0000:06:07.0: bridge window [io 0xf000-0xffff]
[ 0.233367] pci 0000:06:07.0: bridge window [mem 0xfca00000-0xfcafffff]
[ 0.233400] pci 0000:06:07.0: enabling Extended Tags
[ 0.233483] pci 0000:06:07.0: PME# supported from D3hot D3cold
[ 0.233642] pci 0000:05:00.2: PCI bridge to [bus 06-0c]
[ 0.233704] pci 0000:06:00.0: PCI bridge to [bus 07]
[ 0.233766] pci 0000:06:01.0: PCI bridge to [bus 08]
[ 0.233829] pci 0000:06:04.0: PCI bridge to [bus 09]
[ 0.233893] pci 0000:06:05.0: PCI bridge to [bus 0a]
[ 0.234018] pci 0000:0b:00.0: [8086:24fb] type 00 class 0x028000 PCIe 
Endpoint
[ 0.234071] pci 0000:0b:00.0: BAR 0 [mem 0xfcb00000-0xfcb01fff 64bit]
[ 0.234341] pci 0000:0b:00.0: PME# supported from D0 D3hot D3cold
[ 0.234633] pci 0000:06:06.0: PCI bridge to [bus 0b]
[ 0.234748] pci 0000:0c:00.0: [8086:1539] type 00 class 0x020000 PCIe 
Endpoint
[ 0.234789] pci 0000:0c:00.0: BAR 0 [mem 0xfca00000-0xfca1ffff]
[ 0.234831] pci 0000:0c:00.0: BAR 2 [io 0xf000-0xf01f]
[ 0.234854] pci 0000:0c:00.0: BAR 3 [mem 0xfca20000-0xfca23fff]
[ 0.235070] pci 0000:0c:00.0: PME# supported from D0 D3hot D3cold
[ 0.235278] pci 0000:06:07.0: PCI bridge to [bus 0c]
[ 0.235412] pci 0000:0d:00.0: [126f:2262] type 00 class 0x010802 PCIe 
Endpoint
[ 0.235443] pci 0000:0d:00.0: BAR 0 [mem 0xfce00000-0xfce03fff 64bit]
[ 0.235751] pci 0000:00:01.6: PCI bridge to [bus 0d]
[ 0.235847] pci 0000:0e:00.0: [1002:15dd] type 00 class 0x030000 PCIe 
Legacy Endpoint
[ 0.235881] pci 0000:0e:00.0: BAR 0 [mem 0xe0000000-0xefffffff 64bit 
pref]
[ 0.235904] pci 0000:0e:00.0: BAR 2 [mem 0xf0000000-0xf01fffff 64bit 
pref]
[ 0.235921] pci 0000:0e:00.0: BAR 4 [io 0xe000-0xe0ff]
[ 0.235937] pci 0000:0e:00.0: BAR 5 [mem 0xfc900000-0xfc97ffff]
[ 0.235965] pci 0000:0e:00.0: enabling Extended Tags
[ 0.236011] pci 0000:0e:00.0: Video device with shadowed ROM at [mem 
0x000c0000-0x000dffff]
[ 0.236120] pci 0000:0e:00.0: PME# supported from D1 D2 D3hot D3cold
[ 0.236340] pci 0000:0e:00.1: [1002:15de] type 00 class 0x040300 PCIe 
Legacy Endpoint
[ 0.236368] pci 0000:0e:00.1: BAR 0 [mem 0xfc988000-0xfc98bfff]
[ 0.236445] pci 0000:0e:00.1: enabling Extended Tags
[ 0.236521] pci 0000:0e:00.1: PME# supported from D1 D2 D3hot D3cold
[ 0.236661] pci 0000:0e:00.2: [1022:15df] type 00 class 0x108000 PCIe 
Endpoint
[ 0.236709] pci 0000:0e:00.2: BAR 2 [mem 0xfc800000-0xfc8fffff]
[ 0.236746] pci 0000:0e:00.2: BAR 5 [mem 0xfc98c000-0xfc98dfff]
[ 0.236770] pci 0000:0e:00.2: enabling Extended Tags
[ 0.236984] pci 0000:0e:00.3: [1022:15e0] type 00 class 0x0c0330 PCIe 
Endpoint
[ 0.237016] pci 0000:0e:00.3: BAR 0 [mem 0xfc700000-0xfc7fffff 64bit]
[ 0.237083] pci 0000:0e:00.3: enabling Extended Tags
[ 0.237165] pci 0000:0e:00.3: PME# supported from D0 D3hot D3cold
[ 0.237328] pci 0000:0e:00.4: [1022:15e1] type 00 class 0x0c0330 PCIe 
Endpoint
[ 0.237360] pci 0000:0e:00.4: BAR 0 [mem 0xfc600000-0xfc6fffff 64bit]
[ 0.237426] pci 0000:0e:00.4: enabling Extended Tags
[ 0.237509] pci 0000:0e:00.4: PME# supported from D0 D3hot D3cold
[ 0.237656] pci 0000:0e:00.6: [1022:15e3] type 00 class 0x040300 PCIe 
Endpoint
[ 0.237683] pci 0000:0e:00.6: BAR 0 [mem 0xfc980000-0xfc987fff]
[ 0.237760] pci 0000:0e:00.6: enabling Extended Tags
[ 0.237836] pci 0000:0e:00.6: PME# supported from D0 D3hot D3cold
[ 0.238011] pci 0000:00:08.1: PCI bridge to [bus 0e]
[ 0.238106] pci 0000:0f:00.0: [1022:7901] type 00 class 0x010601 PCIe 
Endpoint
[ 0.238185] pci 0000:0f:00.0: BAR 5 [mem 0xfcd00000-0xfcd007ff]
[ 0.238210] pci 0000:0f:00.0: enabling Extended Tags
[ 0.238315] pci 0000:0f:00.0: PME# supported from D3hot D3cold
[ 0.238506] pci 0000:00:08.2: PCI bridge to [bus 0f]
[ 0.239076] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[ 0.239142] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[ 0.239198] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[ 0.239268] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[ 0.239330] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[ 0.239382] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[ 0.239434] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[ 0.239486] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[ 0.241364] iommu: Default domain type: Translated
[ 0.241370] iommu: DMA domain TLB invalidation policy: lazy mode
[ 0.241447] SCSI subsystem initialized
[ 0.241953] libata version 3.00 loaded.
[ 0.241978] ACPI: bus type USB registered
[ 0.241997] usbcore: registered new interface driver usbfs
[ 0.242009] usbcore: registered new interface driver hub
[ 0.242021] usbcore: registered new device driver usb
[ 0.242041] pps_core: LinuxPPS API ver. 1 registered
[ 0.242046] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo 
Giometti <giometti@linux.it>
[ 0.242055] PTP clock support registered
[ 0.242146] efivars: Registered efivars operations
[ 0.242146] Advanced Linux Sound Architecture Driver Initialized.
[ 0.242146] NetLabel: Initializing
[ 0.242146] NetLabel: domain hash size = 128
[ 0.242146] NetLabel: protocols = UNLABELED CIPSOv4 CALIPSO
[ 0.242170] NetLabel: unlabeled traffic allowed by default
[ 0.242961] PCI: Using ACPI for IRQ routing
[ 0.244880] PCI: pci_cache_line_size set to 64 bytes
[ 0.245005] e820: reserve RAM buffer [mem 0x09d02000-0x0bffffff]
[ 0.245008] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
[ 0.245010] e820: reserve RAM buffer [mem 0x0b000000-0x0bffffff]
[ 0.245012] e820: reserve RAM buffer [mem 0x57082018-0x57ffffff]
[ 0.245014] e820: reserve RAM buffer [mem 0x5719a000-0x57ffffff]
[ 0.245015] e820: reserve RAM buffer [mem 0x57754000-0x57ffffff]
[ 0.245017] e820: reserve RAM buffer [mem 0x5aed1000-0x5bffffff]
[ 0.245019] e820: reserve RAM buffer [mem 0x5f000000-0x5fffffff]
[ 0.245021] e820: reserve RAM buffer [mem 0x21f340000-0x21fffffff]
[ 0.245961] pci 0000:0e:00.0: vgaarb: setting as boot VGA device
[ 0.245967] pci 0000:0e:00.0: vgaarb: bridge control possible
[ 0.245972] pci 0000:0e:00.0: vgaarb: VGA device added: 
decodes=io+mem,owns=io+mem,locks=none
[ 0.245981] vgaarb: loaded
[ 0.246117] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[ 0.246128] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[ 0.248643] clocksource: Switched to clocksource tsc-early
[ 0.248893] VFS: Disk quotas dquot_6.6.0
[ 0.248893] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 
bytes)
[ 0.248893] pnp: PnP ACPI init
[ 0.248894] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
[ 0.249251] system 00:01: [mem 0xfeb80000-0xfebfffff] has been reserved
[ 0.249333] system 00:02: [mem 0x60000000-0xdfffffff window] has been 
reserved
[ 0.249699] system 00:04: [io 0x0280-0x028f] has been reserved
[ 0.249706] system 00:04: [io 0x0290-0x029f] has been reserved
[ 0.249712] system 00:04: [io 0x02a0-0x02af] has been reserved
[ 0.249718] system 00:04: [io 0x02b0-0x02bf] has been reserved
[ 0.249984] system 00:05: [io 0x04d0-0x04d1] has been reserved
[ 0.249991] system 00:05: [io 0x040b] has been reserved
[ 0.249997] system 00:05: [io 0x04d6] has been reserved
[ 0.250003] system 00:05: [io 0x0c00-0x0c01] has been reserved
[ 0.250009] system 00:05: [io 0x0c14] has been reserved
[ 0.250015] system 00:05: [io 0x0c50-0x0c51] has been reserved
[ 0.250021] system 00:05: [io 0x0c52] has been reserved
[ 0.250026] system 00:05: [io 0x0c6c] has been reserved
[ 0.250032] system 00:05: [io 0x0c6f] has been reserved
[ 0.250038] system 00:05: [io 0x0cd0-0x0cd1] has been reserved
[ 0.250044] system 00:05: [io 0x0cd2-0x0cd3] has been reserved
[ 0.250049] system 00:05: [io 0x0cd4-0x0cd5] has been reserved
[ 0.250055] system 00:05: [io 0x0cd6-0x0cd7] has been reserved
[ 0.250061] system 00:05: [io 0x0cd8-0x0cdf] has been reserved
[ 0.250067] system 00:05: [io 0x0800-0x089f] has been reserved
[ 0.250073] system 00:05: [io 0x0b00-0x0b0f] has been reserved
[ 0.250079] system 00:05: [io 0x0b20-0x0b3f] has been reserved
[ 0.250085] system 00:05: [io 0x0900-0x090f] has been reserved
[ 0.250091] system 00:05: [io 0x0910-0x091f] has been reserved
[ 0.250098] system 00:05: [mem 0xfec00000-0xfec00fff] could not be 
reserved
[ 0.250105] system 00:05: [mem 0xfec01000-0xfec01fff] could not be 
reserved
[ 0.250111] system 00:05: [mem 0xfedc0000-0xfedc0fff] has been reserved
[ 0.250118] system 00:05: [mem 0xfee00000-0xfee00fff] has been reserved
[ 0.250124] system 00:05: [mem 0xfed80000-0xfed8ffff] could not be 
reserved
[ 0.250131] system 00:05: [mem 0xfec10000-0xfec10fff] has been reserved
[ 0.250137] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[ 0.250616] pnp: PnP ACPI: found 6 devices
[ 0.256885] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, 
max_idle_ns: 2085701024 ns
[ 0.256917] NET: Registered PF_INET protocol family
[ 0.257016] IP idents hash table entries: 131072 (order: 8, 1048576 
bytes, linear)
[ 0.258438] tcp_listen_portaddr_hash hash table entries: 4096 (order: 
4, 65536 bytes, linear)
[ 0.258452] Table-perturb hash table entries: 65536 (order: 6, 262144 
bytes, linear)
[ 0.258461] TCP established hash table entries: 65536 (order: 7, 524288 
bytes, linear)
[ 0.258523] TCP bind hash table entries: 65536 (order: 9, 2097152 
bytes, linear)
[ 0.258666] TCP: Hash tables configured (established 65536 bind 65536)
[ 0.258700] UDP hash table entries: 4096 (order: 6, 262144 bytes, 
linear)
[ 0.258730] UDP-Lite hash table entries: 4096 (order: 6, 262144 bytes, 
linear)
[ 0.258792] NET: Registered PF_UNIX/PF_LOCAL protocol family
[ 0.258904] RPC: Registered named UNIX socket transport module.
[ 0.258910] RPC: Registered udp transport module.
[ 0.258914] RPC: Registered tcp transport module.
[ 0.258919] RPC: Registered tcp-with-tls transport module.
[ 0.258923] RPC: Registered tcp NFSv4.1 backchannel transport module.
[ 0.259418] pci 0000:00:01.6: bridge window [io 0x1000-0x0fff] to [bus 
0d] add_size 1000
[ 0.259428] pci 0000:00:01.6: bridge window [mem 0x00100000-0x000fffff 
64bit pref] to [bus 0d] add_size 200000 add_align 100000
[ 0.259446] pci 0000:00:01.6: bridge window [mem 0xf0200000-0xf03fffff 
64bit pref]: assigned
[ 0.259455] pci 0000:00:01.6: bridge window [io 0x1000-0x1fff]: assigned
[ 0.259463] pci 0000:02:01.0: PCI bridge to [bus 03]
[ 0.259473] pci 0000:02:01.0: bridge window [mem 0xfc400000-0xfc5fffff]
[ 0.259487] pci 0000:02:02.0: PCI bridge to [bus 04]
[ 0.259496] pci 0000:02:02.0: bridge window [mem 0xfc200000-0xfc3fffff]
[ 0.259509] pci 0000:01:00.0: PCI bridge to [bus 02-04]
[ 0.259518] pci 0000:01:00.0: bridge window [mem 0xfc200000-0xfc5fffff]
[ 0.259532] pci 0000:00:01.1: PCI bridge to [bus 01-04]
[ 0.259541] pci 0000:00:01.1: bridge window [mem 0xfc200000-0xfc5fffff]
[ 0.259556] pci 0000:06:00.0: PCI bridge to [bus 07]
[ 0.259573] pci 0000:06:01.0: PCI bridge to [bus 08]
[ 0.259589] pci 0000:06:04.0: PCI bridge to [bus 09]
[ 0.259605] pci 0000:06:05.0: PCI bridge to [bus 0a]
[ 0.259622] pci 0000:06:06.0: PCI bridge to [bus 0b]
[ 0.259631] pci 0000:06:06.0: bridge window [mem 0xfcb00000-0xfcbfffff]
[ 0.259645] pci 0000:06:07.0: PCI bridge to [bus 0c]
[ 0.259651] pci 0000:06:07.0: bridge window [io 0xf000-0xffff]
[ 0.259661] pci 0000:06:07.0: bridge window [mem 0xfca00000-0xfcafffff]
[ 0.259675] pci 0000:05:00.2: PCI bridge to [bus 06-0c]
[ 0.259681] pci 0000:05:00.2: bridge window [io 0xf000-0xffff]
[ 0.259690] pci 0000:05:00.2: bridge window [mem 0xfca00000-0xfcbfffff]
[ 0.259704] pci 0000:00:01.2: PCI bridge to [bus 05-0c]
[ 0.259710] pci 0000:00:01.2: bridge window [io 0xf000-0xffff]
[ 0.259719] pci 0000:00:01.2: bridge window [mem 0xfca00000-0xfccfffff]
[ 0.259733] pci 0000:00:01.6: PCI bridge to [bus 0d]
[ 0.259739] pci 0000:00:01.6: bridge window [io 0x1000-0x1fff]
[ 0.259749] pci 0000:00:01.6: bridge window [mem 0xfce00000-0xfcefffff]
[ 0.259757] pci 0000:00:01.6: bridge window [mem 0xf0200000-0xf03fffff 
64bit pref]
[ 0.259772] pci 0000:00:08.1: PCI bridge to [bus 0e]
[ 0.259783] pci 0000:00:08.1: bridge window [io 0xe000-0xefff]
[ 0.259792] pci 0000:00:08.1: bridge window [mem 0xfc600000-0xfc9fffff]
[ 0.259801] pci 0000:00:08.1: bridge window [mem 0xe0000000-0xf01fffff 
64bit pref]
[ 0.259813] pci 0000:00:08.2: PCI bridge to [bus 0f]
[ 0.259822] pci 0000:00:08.2: bridge window [mem 0xfcd00000-0xfcdfffff]
[ 0.259837] pci_bus 0000:00: resource 4 [io 0x0000-0x03af window]
[ 0.259843] pci_bus 0000:00: resource 5 [io 0x03e0-0x0cf7 window]
[ 0.259849] pci_bus 0000:00: resource 6 [io 0x03b0-0x03df window]
[ 0.259855] pci_bus 0000:00: resource 7 [io 0x0d00-0xffff window]
[ 0.259861] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff 
window]
[ 0.259868] pci_bus 0000:00: resource 9 [mem 0xe0000000-0xfec2ffff 
window]
[ 0.259874] pci_bus 0000:00: resource 10 [mem 0xfee00000-0xffffffff 
window]
[ 0.259880] pci_bus 0000:01: resource 1 [mem 0xfc200000-0xfc5fffff]
[ 0.259887] pci_bus 0000:02: resource 1 [mem 0xfc200000-0xfc5fffff]
[ 0.259893] pci_bus 0000:03: resource 1 [mem 0xfc400000-0xfc5fffff]
[ 0.259899] pci_bus 0000:04: resource 1 [mem 0xfc200000-0xfc3fffff]
[ 0.259905] pci_bus 0000:05: resource 0 [io 0xf000-0xffff]
[ 0.259911] pci_bus 0000:05: resource 1 [mem 0xfca00000-0xfccfffff]
[ 0.259917] pci_bus 0000:06: resource 0 [io 0xf000-0xffff]
[ 0.259922] pci_bus 0000:06: resource 1 [mem 0xfca00000-0xfcbfffff]
[ 0.259929] pci_bus 0000:0b: resource 1 [mem 0xfcb00000-0xfcbfffff]
[ 0.259935] pci_bus 0000:0c: resource 0 [io 0xf000-0xffff]
[ 0.259940] pci_bus 0000:0c: resource 1 [mem 0xfca00000-0xfcafffff]
[ 0.259946] pci_bus 0000:0d: resource 0 [io 0x1000-0x1fff]
[ 0.259952] pci_bus 0000:0d: resource 1 [mem 0xfce00000-0xfcefffff]
[ 0.259958] pci_bus 0000:0d: resource 2 [mem 0xf0200000-0xf03fffff 
64bit pref]
[ 0.259965] pci_bus 0000:0e: resource 0 [io 0xe000-0xefff]
[ 0.259971] pci_bus 0000:0e: resource 1 [mem 0xfc600000-0xfc9fffff]
[ 0.259977] pci_bus 0000:0e: resource 2 [mem 0xe0000000-0xf01fffff 
64bit pref]
[ 0.259984] pci_bus 0000:0f: resource 1 [mem 0xfcd00000-0xfcdfffff]
[ 0.260274] pci 0000:0e:00.1: D0 power state depends on 0000:0e:00.0
[ 0.260293] pci 0000:0e:00.3: extending delay after power-on from D3hot 
to 20 msec
[ 0.260502] pci 0000:0e:00.4: extending delay after power-on from D3hot 
to 20 msec
[ 0.260613] PCI: CLS 64 bytes, default 64
[ 0.260632] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[ 0.260638] software IO TLB: mapped [mem 
0x0000000053082000-0x0000000057082000] (64MB)
[ 0.260663] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 
163840 ms ovfl timer
[ 0.260670] RAPL PMU: hw unit of domain package 2^-16 Joules
[ 0.263497] amd_uncore: 4 amd_df counters detected
[ 0.263507] amd_uncore: 6 amd_l3 counters detected
[ 0.293134] Initialise system trusted keyrings
[ 0.293170] workingset: timestamp_bits=40 max_order=21 bucket_order=0
[ 0.293296] NFS: Registering the id_resolver key type
[ 0.293305] Key type id_resolver registered
[ 0.293309] Key type id_legacy registered
[ 0.305938] Key type asymmetric registered
[ 0.305944] Asymmetric key parser 'x509' registered
[ 0.305960] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 251)
[ 0.305967] io scheduler mq-deadline registered
[ 0.305972] io scheduler kyber registered
[ 0.306126] pcieport 0000:00:01.1: PME: Signaling with IRQ 25
[ 0.306300] pcieport 0000:00:01.2: PME: Signaling with IRQ 26
[ 0.306473] pcieport 0000:00:01.6: PME: Signaling with IRQ 27
[ 0.306650] pcieport 0000:00:08.1: PME: Signaling with IRQ 28
[ 0.306866] pcieport 0000:00:08.2: PME: Signaling with IRQ 29
[ 0.308478] input: Power Button as 
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[ 0.308513] ACPI: button: Power Button [PWRB]
[ 0.308561] input: Power Button as 
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[ 0.308624] ACPI: button: Power Button [PWRF]
[ 0.308690] ACPI: video: Video Device [VGA] (multi-head: yes rom: no 
post: no)
[ 0.308879] input: Video Bus as 
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:01/LNXVIDEO:00/input/input2
[ 0.308954] ACPI: video: Video Device [VGA1] (multi-head: yes rom: no 
post: no)
[ 0.309020] input: Video Bus as 
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:0f/LNXVIDEO:01/input/input3
[ 0.309659] Could not retrieve perf counters (-19)
[ 0.309823] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[ 0.310386] Non-volatile memory driver v1.3
[ 0.310391] Linux agpgart interface v0.103
[ 0.310823] ACPI: bus type drm_connector registered
[ 0.310837] [drm] amdgpu kernel modesetting enabled.
[ 0.310975] [drm] initializing kernel modesetting (RAVEN 0x1002:0x15DD 
0x1002:0x15DD 0xC6).
[ 0.310989] [drm] register mmio base: 0xFC900000
[ 0.310994] [drm] register mmio size: 524288
[ 0.311024] [drm] add ip block number 0 <soc15_common>
[ 0.311029] [drm] add ip block number 1 <gmc_v9_0>
[ 0.311034] [drm] add ip block number 2 <vega10_ih>
[ 0.311039] [drm] add ip block number 3 <psp>
[ 0.311043] [drm] add ip block number 4 <powerplay>
[ 0.311047] [drm] add ip block number 5 <dm>
[ 0.311052] [drm] add ip block number 6 <gfx_v9_0>
[ 0.311057] [drm] add ip block number 7 <sdma_v4_0>
[ 0.311061] [drm] add ip block number 8 <vcn_v1_0>
[ 0.334228] [drm] BIOS signature incorrect 0 0
[ 0.334251] amdgpu 0000:0e:00.0: amdgpu: Fetched VBIOS from ROM BAR
[ 0.334258] amdgpu: ATOM BIOS: 113-RAVEN-113
[ 0.334554] amdgpu 0000:0e:00.0: vgaarb: deactivate vga console
[ 0.334560] amdgpu 0000:0e:00.0: amdgpu: Trusted Memory Zone (TMZ) 
feature enabled
[ 0.334585] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, 
fragment size is 9-bit
[ 0.334596] amdgpu 0000:0e:00.0: amdgpu: VRAM: 2048M 0x000000F400000000 
- 0x000000F47FFFFFFF (2048M used)
[ 0.334604] amdgpu 0000:0e:00.0: amdgpu: GART: 1024M 0x0000000000000000 
- 0x000000003FFFFFFF
[ 0.334615] [drm] Detected VRAM RAM=2048M, BAR=2048M
[ 0.334619] [drm] RAM width 128bits DDR4
[ 0.334722] [drm] amdgpu: 2048M of VRAM memory ready
[ 0.334727] [drm] amdgpu: 2923M of GTT memory ready.
[ 0.334742] [drm] GART: num cpu pages 262144, num gpu pages 262144
[ 0.334877] [drm] PCIE GART of 1024M enabled.
[ 0.334881] [drm] PTB located at 0x000000F400A00000
[ 0.335145] amdgpu: hwmgr_sw_init smu backed is smu10_smu
[ 0.335578] [drm] Found VCN firmware Version ENC: 1.15 DEC: 3 VEP: 0 
Revision: 0
[ 0.356133] amdgpu 0000:0e:00.0: amdgpu: reserve 0x400000 from 
0xf47fc00000 for PSP TMR
[ 0.428083] amdgpu 0000:0e:00.0: amdgpu: RAS: optional ras ta ucode is 
not available
[ 0.434083] amdgpu 0000:0e:00.0: amdgpu: RAP: optional rap ta ucode is 
not available
[ 0.434090] amdgpu 0000:0e:00.0: amdgpu: SECUREDISPLAY: securedisplay 
ta ucode is not available
[ 0.434559] [drm] DM_PPLIB: values for F clock
[ 0.434564] [drm] DM_PPLIB: 1633000 in kHz, 4399 in mV
[ 0.434570] [drm] DM_PPLIB: values for DCF clock
[ 0.434574] [drm] DM_PPLIB: 300000 in kHz, 3649 in mV
[ 0.434578] [drm] DM_PPLIB: 600000 in kHz, 4074 in mV
[ 0.434583] [drm] DM_PPLIB: 626000 in kHz, 4250 in mV
[ 0.434587] [drm] DM_PPLIB: 654000 in kHz, 4399 in mV
[ 0.435247] [drm] Display Core v3.2.310 initialized on DCN 1.0
[ 0.504716] [drm] kiq ring mec 2 pipe 1 q 0
[ 0.518487] amdgpu 0000:0e:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 
11, active_cu_number 11
[ 0.518497] amdgpu 0000:0e:00.0: amdgpu: ring gfx uses VM inv eng 0 on 
hub 0
[ 0.518503] amdgpu 0000:0e:00.0: amdgpu: ring comp_1.0.0 uses VM inv 
eng 1 on hub 0
[ 0.518510] amdgpu 0000:0e:00.0: amdgpu: ring comp_1.1.0 uses VM inv 
eng 4 on hub 0
[ 0.518516] amdgpu 0000:0e:00.0: amdgpu: ring comp_1.2.0 uses VM inv 
eng 5 on hub 0
[ 0.518523] amdgpu 0000:0e:00.0: amdgpu: ring comp_1.3.0 uses VM inv 
eng 6 on hub 0
[ 0.518530] amdgpu 0000:0e:00.0: amdgpu: ring comp_1.0.1 uses VM inv 
eng 7 on hub 0
[ 0.518536] amdgpu 0000:0e:00.0: amdgpu: ring comp_1.1.1 uses VM inv 
eng 8 on hub 0
[ 0.518543] amdgpu 0000:0e:00.0: amdgpu: ring comp_1.2.1 uses VM inv 
eng 9 on hub 0
[ 0.518549] amdgpu 0000:0e:00.0: amdgpu: ring comp_1.3.1 uses VM inv 
eng 10 on hub 0
[ 0.518556] amdgpu 0000:0e:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv 
eng 11 on hub 0
[ 0.518562] amdgpu 0000:0e:00.0: amdgpu: ring sdma0 uses VM inv eng 0 
on hub 8
[ 0.518569] amdgpu 0000:0e:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 
on hub 8
[ 0.518575] amdgpu 0000:0e:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 
4 on hub 8
[ 0.518581] amdgpu 0000:0e:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 
5 on hub 8
[ 0.518588] amdgpu 0000:0e:00.0: amdgpu: ring jpeg_dec uses VM inv eng 
6 on hub 8
[ 0.521453] amdgpu: pp_dpm_get_sclk_od was not implemented.
[ 0.521460] amdgpu: pp_dpm_get_mclk_od was not implemented.
[ 0.521565] amdgpu 0000:0e:00.0: amdgpu: Runtime PM not available
[ 0.521868] [drm] Initialized amdgpu 3.60.0 for 0000:0e:00.0 on minor 0
[ 0.526617] fbcon: amdgpudrmfb (fb0) is primary device
[ 0.595813] Console: switching to colour frame buffer device 240x67
[ 0.628478] amdgpu 0000:0e:00.0: [drm] fb0: amdgpudrmfb frame buffer 
device
[ 0.631424] loop: module loaded
[ 0.631631] ahci 0000:05:00.1: version 3.0
[ 0.631682] nvme nvme0: pci function 0000:0d:00.0
[ 0.631769] ahci 0000:05:00.1: SSS flag set, parallel bus scan disabled
[ 0.631842] ahci 0000:05:00.1: AHCI vers 0001.0301, 32 command slots, 6 
Gbps, SATA mode
[ 0.631858] ahci 0000:05:00.1: 4/8 ports implemented (port mask 0x33)
[ 0.631872] ahci 0000:05:00.1: flags: 64bit ncq sntf stag pm led clo 
only pmp pio slum part sxs deso sadm sds apst
[ 0.632508] scsi host0: ahci
[ 0.632620] scsi host1: ahci
[ 0.632724] scsi host2: ahci
[ 0.632827] scsi host3: ahci
[ 0.632929] scsi host4: ahci
[ 0.633038] scsi host5: ahci
[ 0.633138] scsi host6: ahci
[ 0.633239] scsi host7: ahci
[ 0.633289] ata1: SATA max UDMA/133 abar m131072@0xfcc80000 port 
0xfcc80100 irq 43 lpm-pol 3
[ 0.633305] ata2: SATA max UDMA/133 abar m131072@0xfcc80000 port 
0xfcc80180 irq 43 lpm-pol 3
[ 0.633320] ata3: DUMMY
[ 0.633328] ata4: DUMMY
[ 0.633336] ata5: SATA max UDMA/133 abar m131072@0xfcc80000 port 
0xfcc80300 irq 43 lpm-pol 3
[ 0.633352] ata6: SATA max UDMA/133 abar m131072@0xfcc80000 port 
0xfcc80380 irq 43 lpm-pol 3
[ 0.633370] ata7: DUMMY
[ 0.633377] ata8: DUMMY
[ 0.635101] nvme nvme0: missing or invalid SUBNQN field.
[ 0.636647] nvme nvme0: 8/0/0 default/read/poll queues
[ 0.637254] nvme nvme0: Ignoring bogus Namespace Identifiers
[ 0.638286] nvme0n1: p1 p2 p3 p4 p5 p6
[ 0.644412] ahci 0000:0f:00.0: AHCI vers 0001.0301, 32 command slots, 6 
Gbps, SATA mode
[ 0.644434] ahci 0000:0f:00.0: 1/1 ports implemented (port mask 0x1)
[ 0.644451] ahci 0000:0f:00.0: flags: 64bit ncq sntf ilck pm led clo 
only pmp fbs pio slum part
[ 0.644685] scsi host8: ahci
[ 0.644746] ata9: SATA max UDMA/133 abar m2048@0xfcd00000 port 
0xfcd00100 irq 46 lpm-pol 3
[ 0.645073] e100: Intel(R) PRO/100 Network Driver
[ 0.645085] e100: Copyright(c) 1999-2006 Intel Corporation
[ 0.645108] e1000: Intel(R) PRO/1000 Network Driver
[ 0.645119] e1000: Copyright (c) 1999-2006 Intel Corporation.
[ 0.645142] e1000e: Intel(R) PRO/1000 Network Driver
[ 0.645153] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[ 0.645180] sky2: driver version 1.30
[ 0.645415] xhci_hcd 0000:05:00.0: xHCI Host Controller
[ 0.645466] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus 
number 1
[ 0.701390] xhci_hcd 0000:05:00.0: hcc params 0x0200ef81 hci version 
0x110 quirks 0x0000000000000010
[ 0.702253] xhci_hcd 0000:05:00.0: xHCI Host Controller
[ 0.704075] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus 
number 2
[ 0.704703] xhci_hcd 0000:05:00.0: Host supports USB 3.1 Enhanced 
SuperSpeed
[ 0.705294] usb usb1: New USB device found, idVendor=1d6b, 
idProduct=0002, bcdDevice= 6.13
[ 0.705803] usb usb1: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[ 0.706307] usb usb1: Product: xHCI Host Controller
[ 0.706801] usb usb1: Manufacturer: Linux 6.13.4 xhci-hcd
[ 0.707292] usb usb1: SerialNumber: 0000:05:00.0
[ 0.707927] hub 1-0:1.0: USB hub found
[ 0.708444] hub 1-0:1.0: 10 ports detected
[ 0.709749] usb usb2: We don't know the algorithms for LPM for this 
host, disabling LPM.
[ 0.710277] usb usb2: New USB device found, idVendor=1d6b, 
idProduct=0003, bcdDevice= 6.13
[ 0.710820] usb usb2: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[ 0.711729] usb usb2: Product: xHCI Host Controller
[ 0.712348] usb usb2: Manufacturer: Linux 6.13.4 xhci-hcd
[ 0.712834] usb usb2: SerialNumber: 0000:05:00.0
[ 0.713417] hub 2-0:1.0: USB hub found
[ 0.713894] hub 2-0:1.0: 4 ports detected
[ 0.715137] xhci_hcd 0000:0e:00.3: xHCI Host Controller
[ 0.715664] xhci_hcd 0000:0e:00.3: new USB bus registered, assigned bus 
number 3
[ 0.716323] xhci_hcd 0000:0e:00.3: hcc params 0x0270ffe5 hci version 
0x110 quirks 0x0000000840000010
[ 0.717140] xhci_hcd 0000:0e:00.3: xHCI Host Controller
[ 0.717656] xhci_hcd 0000:0e:00.3: new USB bus registered, assigned bus 
number 4
[ 0.718129] xhci_hcd 0000:0e:00.3: Host supports USB 3.1 Enhanced 
SuperSpeed
[ 0.718663] usb usb3: New USB device found, idVendor=1d6b, 
idProduct=0002, bcdDevice= 6.13
[ 0.719125] usb usb3: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[ 0.719581] usb usb3: Product: xHCI Host Controller
[ 0.720036] usb usb3: Manufacturer: Linux 6.13.4 xhci-hcd
[ 0.720490] usb usb3: SerialNumber: 0000:0e:00.3
[ 0.721079] hub 3-0:1.0: USB hub found
[ 0.721560] hub 3-0:1.0: 4 ports detected
[ 0.722370] usb usb4: We don't know the algorithms for LPM for this 
host, disabling LPM.
[ 0.722852] usb usb4: New USB device found, idVendor=1d6b, 
idProduct=0003, bcdDevice= 6.13
[ 0.723307] usb usb4: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[ 0.723756] usb usb4: Product: xHCI Host Controller
[ 0.724210] usb usb4: Manufacturer: Linux 6.13.4 xhci-hcd
[ 0.724665] usb usb4: SerialNumber: 0000:0e:00.3
[ 0.725241] hub 4-0:1.0: USB hub found
[ 0.725739] hub 4-0:1.0: 4 ports detected
[ 0.726777] xhci_hcd 0000:0e:00.4: xHCI Host Controller
[ 0.727332] xhci_hcd 0000:0e:00.4: new USB bus registered, assigned bus 
number 5
[ 0.728146] xhci_hcd 0000:0e:00.4: hcc params 0x0260ffe5 hci version 
0x110 quirks 0x0000000840000010
[ 0.729157] xhci_hcd 0000:0e:00.4: xHCI Host Controller
[ 0.729731] xhci_hcd 0000:0e:00.4: new USB bus registered, assigned bus 
number 6
[ 0.730227] xhci_hcd 0000:0e:00.4: Host supports USB 3.1 Enhanced 
SuperSpeed
[ 0.730791] usb usb5: New USB device found, idVendor=1d6b, 
idProduct=0002, bcdDevice= 6.13
[ 0.731273] usb usb5: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[ 0.731747] usb usb5: Product: xHCI Host Controller
[ 0.732219] usb usb5: Manufacturer: Linux 6.13.4 xhci-hcd
[ 0.732690] usb usb5: SerialNumber: 0000:0e:00.4
[ 0.733346] hub 5-0:1.0: USB hub found
[ 0.733862] hub 5-0:1.0: 1 port detected
[ 0.734471] usb usb6: We don't know the algorithms for LPM for this 
host, disabling LPM.
[ 0.734988] usb usb6: New USB device found, idVendor=1d6b, 
idProduct=0003, bcdDevice= 6.13
[ 0.735471] usb usb6: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[ 0.735938] usb usb6: Product: xHCI Host Controller
[ 0.736402] usb usb6: Manufacturer: Linux 6.13.4 xhci-hcd
[ 0.736858] usb usb6: SerialNumber: 0000:0e:00.4
[ 0.737428] hub 6-0:1.0: USB hub found
[ 0.737918] hub 6-0:1.0: 1 port detected
[ 0.738514] usbcore: registered new interface driver usblp
[ 0.739019] usbcore: registered new interface driver usb-storage
[ 0.739526] i8042: PNP: No PS/2 controller found.
[ 0.740135] rtc_cmos 00:03: RTC can wake from S4
[ 0.740986] rtc_cmos 00:03: registered as rtc0
[ 0.741504] rtc_cmos 00:03: alarms up to one month, y3k, 114 bytes 
nvram, hpet irqs
[ 0.742053] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) 
initialised: dm-devel@lists.linux.dev
[ 0.742567] hid: raw HID events driver (C) Jiri Kosina
[ 0.743239] usbcore: registered new interface driver usbhid
[ 0.743706] usbhid: USB HID core driver
[ 0.745347] Initializing XFRM netlink socket
[ 0.745989] NET: Registered PF_INET6 protocol family
[ 0.746743] Segment Routing with IPv6
[ 0.747263] In-situ OAM (IOAM) with IPv6
[ 0.747765] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[ 0.748556] NET: Registered PF_PACKET protocol family
[ 0.749084] Key type dns_resolver registered
[ 0.750229] microcode: Current revision: 0x08101016
[ 0.750382] snd_hda_intel 0000:0e:00.1: bound 0000:0e:00.0 (ops 
amdgpu_dm_audio_component_bind_ops)
[ 0.751412] IPI shorthand broadcast: enabled
[ 0.751872] input: HD-Audio Generic HDMI/DP,pcm=3 as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.1/sound/card0/input4
[ 0.752499] input: HD-Audio Generic HDMI/DP,pcm=7 as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.1/sound/card0/input5
[ 0.753078] input: HD-Audio Generic HDMI/DP,pcm=8 as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.1/sound/card0/input6
[ 0.758137] sched_clock: Marking stable (756733801, 
524801)->(769478608, -12220006)
[ 0.758782] registered taskstats version 1
[ 0.759279] Loading compiled-in X.509 certificates
[ 0.760821] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC1220: 
line_outs=3 (0x14/0x15/0x16/0x0/0x0) type:line
[ 0.761744] snd_hda_codec_realtek hdaudioC1D0: speaker_outs=0 
(0x0/0x0/0x0/0x0/0x0)
[ 0.762466] snd_hda_codec_realtek hdaudioC1D0: hp_outs=1 
(0x1b/0x0/0x0/0x0/0x0)
[ 0.762971] snd_hda_codec_realtek hdaudioC1D0: mono: mono_out=0x0
[ 0.763440] snd_hda_codec_realtek hdaudioC1D0: dig-out=0x1e/0x0
[ 0.763894] snd_hda_codec_realtek hdaudioC1D0: inputs:
[ 0.764344] snd_hda_codec_realtek hdaudioC1D0: Rear Mic=0x18
[ 0.764788] snd_hda_codec_realtek hdaudioC1D0: Front Mic=0x19
[ 0.765232] snd_hda_codec_realtek hdaudioC1D0: Line=0x1a
[ 0.765680] Demotion targets for Node 0: null
[ 0.766226] PM: Magic number: 9:18:89
[ 0.766755] printk: legacy console [netcon0] enabled
[ 0.767222] netconsole: network logging started
[ 0.767774] acpi_cpufreq: overriding BIOS provided _PSD data
[ 0.768564] cfg80211: Loading compiled-in X.509 certificates for 
regulatory database
[ 0.769093] kworker/u32:9 (146) used greatest stack depth: 14944 bytes 
left
[ 0.769337] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[ 0.769594] kworker/u32:9 (147) used greatest stack depth: 14456 bytes 
left
[ 0.770238] Loaded X.509 cert 'wens: 
61c038651aabdcf94bd0ac7ff06c7248db18c600'
[ 0.771109] clk: Disabling unused clocks
[ 0.771600] ALSA device list:
[ 0.772136] #0: HD-Audio Generic at 0xfc988000 irq 74
[ 0.772655] platform regulatory.0: Direct firmware load for 
regulatory.db failed with error -2
[ 0.773170] cfg80211: failed to load regulatory.db
[ 0.788828] input: HD-Audio Generic Rear Mic as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.6/sound/card1/input7
[ 0.789533] input: HD-Audio Generic Front Mic as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.6/sound/card1/input8
[ 0.790092] input: HD-Audio Generic Line as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.6/sound/card1/input9
[ 0.790625] input: HD-Audio Generic Line Out Front as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.6/sound/card1/input10
[ 0.791158] input: HD-Audio Generic Line Out Surround as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.6/sound/card1/input11
[ 0.791693] input: HD-Audio Generic Line Out CLFE as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.6/sound/card1/input12
[ 0.792234] input: HD-Audio Generic Front Headphone as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.6/sound/card1/input13
[ 0.949282] ata9: SATA link down (SStatus 0 SControl 300)
[ 0.960022] usb 3-2: new full-speed USB device number 2 using xhci_hcd
[ 1.013024] usb 1-6: new full-speed USB device number 2 using xhci_hcd
[ 1.103613] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[ 1.105312] ata1.00: ATA-10: ST4000VN008-2DR166, SC60, max UDMA/133
[ 1.106330] ata1.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 
32), AA
[ 1.106869] ata1.00: Features: NCQ-sndrcv
[ 1.108523] ata1.00: configured for UDMA/133
[ 1.111675] usb 3-2: New USB device found, idVendor=046d, 
idProduct=c08f, bcdDevice=45.01
[ 1.112281] usb 3-2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[ 1.112804] usb 3-2: Product: G403 HERO Gaming Mouse
[ 1.113298] usb 3-2: Manufacturer: Logitech
[ 1.113789] usb 3-2: SerialNumber: 197431693131
[ 1.119220] scsi 0:0:0:0: Direct-Access ATA ST4000VN008-2DR1 SC60 PQ: 0 
ANSI: 5
[ 1.120033] sd 0:0:0:0: Attached scsi generic sg0 type 0
[ 1.120052] sd 0:0:0:0: [sda] 7814037168 512-byte logical blocks: (4.00 
TB/3.64 TiB)
[ 1.121153] sd 0:0:0:0: [sda] 4096-byte physical blocks
[ 1.121676] sd 0:0:0:0: [sda] Write Protect is off
[ 1.122175] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[ 1.122189] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 1.122713] sd 0:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
[ 1.132864] input: Logitech G403 HERO Gaming Mouse as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.3/usb3/3-2/3-2:1.0/0003:046D:C08F.0001/input/input14
[ 1.133568] hid-generic 0003:046D:C08F.0001: input,hidraw0: USB HID 
v1.11 Mouse [Logitech G403 HERO Gaming Mouse] on 
usb-0000:0e:00.3-2/input0
[ 1.141037] input: Logitech G403 HERO Gaming Mouse Keyboard as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.3/usb3/3-2/3-2:1.1/0003:046D:C08F.0002/input/input15
[ 1.178255] sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8
[ 1.180409] sd 0:0:0:0: [sda] Attached SCSI disk
[ 1.192631] hid-generic 0003:046D:C08F.0002: input,hiddev96,hidraw1: 
USB HID v1.11 Keyboard [Logitech G403 HERO Gaming Mouse] on 
usb-0000:0e:00.3-2/input1
[ 1.295579] tsc: Refined TSC clocksource calibration: 3899.980 MHz
[ 1.296258] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 
0x706e919c8ed, max_idle_ns: 881591200829 ns
[ 1.296872] clocksource: Switched to clocksource tsc
[ 1.304543] usb 3-3: new full-speed USB device number 3 using xhci_hcd
[ 1.378604] usb 1-6: New USB device found, idVendor=8087, 
idProduct=0aa7, bcdDevice= 0.01
[ 1.379281] usb 1-6: New USB device strings: Mfr=0, Product=0, 
SerialNumber=0
[ 1.428607] ata2: SATA link down (SStatus 0 SControl 300)
[ 1.454672] usb 3-3: New USB device found, idVendor=046d, 
idProduct=c33c, bcdDevice=19.01
[ 1.455342] usb 3-3: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[ 1.455946] usb 3-3: Product: G513 RGB MECHANICAL GAMING KEYBOARD
[ 1.456509] usb 3-3: Manufacturer: Logitech
[ 1.457065] usb 3-3: SerialNumber: 096A30493232
[ 1.476892] input: Logitech G513 RGB MECHANICAL GAMING KEYBOARD as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.3/usb3/3-3/3-3:1.0/0003:046D:C33C.0003/input/input18
[ 1.528714] hid-generic 0003:046D:C33C.0003: input,hidraw2: USB HID 
v1.11 Keyboard [Logitech G513 RGB MECHANICAL GAMING KEYBOARD] on 
usb-0000:0e:00.3-3/input0
[ 1.535941] input: Logitech G513 RGB MECHANICAL GAMING KEYBOARD 
Keyboard as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.3/usb3/3-3/3-3:1.1/0003:046D:C33C.0004/input/input19
[ 1.587639] hid-generic 0003:046D:C33C.0004: input,hiddev97,hidraw3: 
USB HID v1.11 Keyboard [Logitech G513 RGB MECHANICAL GAMING KEYBOARD] 
on usb-0000:0e:00.3-3/input1
[ 1.732602] ata5: SATA link down (SStatus 0 SControl 330)
[ 2.036605] ata6: SATA link down (SStatus 0 SControl 330)
[ 2.037396] md: Waiting for all devices to be available before 
autodetect
[ 2.038297] md: If you don't use raid, use raid=noautodetect
[ 2.039027] md: Autodetecting RAID arrays.
[ 2.039693] md: autorun ...
[ 2.040326] md: ... autorun DONE.
[ 2.043075] EXT4-fs (nvme0n1p5): mounted filesystem 
010dcc07-2ae7-44a9-ad6d-c39d6da3f97d ro with ordered data mode. Quota 
mode: none.
[ 2.043824] VFS: Mounted root (ext4 filesystem) readonly on device 
259:5.
[ 2.044840] devtmpfs: mounted
[ 2.045951] Freeing unused kernel image (initmem) memory: 2932K
[ 2.046736] Write protecting the kernel read-only data: 34816k
[ 2.047686] Freeing unused kernel image (rodata/data gap) memory: 928K
[ 2.119435] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[ 2.120182] Run /sbin/init as init process
[ 2.121337] with arguments:
[ 2.121340] /sbin/init
[ 2.121341] with environment:
[ 2.121343] HOME=/
[ 2.121344] TERM=linux
[ 2.121346] BOOT_IMAGE=/boot/vmlinuz-6.13.4-lfs-12.3
[ 2.144037] stty (164) used greatest stack depth: 13064 bytes left
[ 2.166478] sed (177) used greatest stack depth: 12888 bytes left
[ 2.230487] ip (265) used greatest stack depth: 12744 bytes left
[ 2.256793] udevd[290]: Starting systemd-udevd version 257.3
[ 2.264844] udevd[291]: Using default interface naming scheme 'v257'.
[ 3.855606] EXT4-fs (nvme0n1p5): re-mounted 
010dcc07-2ae7-44a9-ad6d-c39d6da3f97d ro. Quota mode: none.
[ 4.046028] EXT4-fs (nvme0n1p5): re-mounted 
010dcc07-2ae7-44a9-ad6d-c39d6da3f97d r/w. Quota mode: none.
[ 4.107083] EXT4-fs (nvme0n1p3): mounted filesystem 
4776d5be-2b47-4fb2-b046-96bed51290f6 r/w with ordered data mode. Quota 
mode: none.
[ 4.154552] EXT4-fs (sda3): mounted filesystem 
8b7415e2-a605-42c0-a983-eb074c2741ef r/w with ordered data mode. Quota 
mode: none.
[ 4.261729] Adding 16777212k swap on /swapfile. Priority:-2 extents:197 
across:50429952k SS
[ 5.012000] setfont (560) used greatest stack depth: 12688 bytes left

Now "on":
[ 0.000000] Linux version 6.13.4 (root@steven-ryzen) (gcc (GCC) 14.2.0, 
GNU ld (GNU Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Thu May 8 13:55:46 
EDT 2025
[ 0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.13.4-lfs-12.3 
root=/dev/nvme0n1p5 ro
[ 0.000000] BIOS-provided physical RAM map:
[ 0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] 
usable
[ 0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] 
reserved
[ 0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009d01fff] 
usable
[ 0.000000] BIOS-e820: [mem 0x0000000009d02000-0x0000000009ffffff] 
reserved
[ 0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff] 
usable
[ 0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a20afff] ACPI 
NVS
[ 0.000000] BIOS-e820: [mem 0x000000000a20b000-0x000000000affffff] 
usable
[ 0.000000] BIOS-e820: [mem 0x000000000b000000-0x000000000b01ffff] 
reserved
[ 0.000000] BIOS-e820: [mem 0x000000000b020000-0x000000005aed0fff] 
usable
[ 0.000000] BIOS-e820: [mem 0x000000005aed1000-0x000000005c3affff] 
reserved
[ 0.000000] BIOS-e820: [mem 0x000000005c3b0000-0x000000005c42cfff] ACPI 
data
[ 0.000000] BIOS-e820: [mem 0x000000005c42d000-0x000000005c93efff] ACPI 
NVS
[ 0.000000] BIOS-e820: [mem 0x000000005c93f000-0x000000005d75efff] 
reserved
[ 0.000000] BIOS-e820: [mem 0x000000005d75f000-0x000000005effffff] 
usable
[ 0.000000] BIOS-e820: [mem 0x000000005f000000-0x00000000dfffffff] 
reserved
[ 0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] 
reserved
[ 0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000ffffffff] 
reserved
[ 0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000021f33ffff] 
usable
[ 0.000000] NX (Execute Disable) protection: active
[ 0.000000] APIC: Static calls initialized
[ 0.000000] e820: update [mem 0x57084018-0x57091457] usable ==> usable
[ 0.000000] extended physical RAM map:
[ 0.000000] reserve setup_data: [mem 
0x0000000000000000-0x000000000009ffff] usable
[ 0.000000] reserve setup_data: [mem 
0x00000000000a0000-0x00000000000fffff] reserved
[ 0.000000] reserve setup_data: [mem 
0x0000000000100000-0x0000000009d01fff] usable
[ 0.000000] reserve setup_data: [mem 
0x0000000009d02000-0x0000000009ffffff] reserved
[ 0.000000] reserve setup_data: [mem 
0x000000000a000000-0x000000000a1fffff] usable
[ 0.000000] reserve setup_data: [mem 
0x000000000a200000-0x000000000a20afff] ACPI NVS
[ 0.000000] reserve setup_data: [mem 
0x000000000a20b000-0x000000000affffff] usable
[ 0.000000] reserve setup_data: [mem 
0x000000000b000000-0x000000000b01ffff] reserved
[ 0.000000] reserve setup_data: [mem 
0x000000000b020000-0x0000000057084017] usable
[ 0.000000] reserve setup_data: [mem 
0x0000000057084018-0x0000000057091457] usable
[ 0.000000] reserve setup_data: [mem 
0x0000000057091458-0x000000005aed0fff] usable
[ 0.000000] reserve setup_data: [mem 
0x000000005aed1000-0x000000005c3affff] reserved
[ 0.000000] reserve setup_data: [mem 
0x000000005c3b0000-0x000000005c42cfff] ACPI data
[ 0.000000] reserve setup_data: [mem 
0x000000005c42d000-0x000000005c93efff] ACPI NVS
[ 0.000000] reserve setup_data: [mem 
0x000000005c93f000-0x000000005d75efff] reserved
[ 0.000000] reserve setup_data: [mem 
0x000000005d75f000-0x000000005effffff] usable
[ 0.000000] reserve setup_data: [mem 
0x000000005f000000-0x00000000dfffffff] reserved
[ 0.000000] reserve setup_data: [mem 
0x00000000f8000000-0x00000000fbffffff] reserved
[ 0.000000] reserve setup_data: [mem 
0x00000000fd000000-0x00000000ffffffff] reserved
[ 0.000000] reserve setup_data: [mem 
0x0000000100000000-0x000000021f33ffff] usable
[ 0.000000] efi: EFI v2.7 by American Megatrends
[ 0.000000] efi: ACPI 2.0=0x5c8bb000 ACPI=0x5c8bb000 SMBIOS=0x5d593000 
SMBIOS 3.0=0x5d592000 MEMATTR=0x577e2018 ESRT=0x59e4ae18 RNG=0x5c42c018
[ 0.000000] random: crng init done
[ 0.000000] efi: Remove mem271: MMIO range=[0xf8000000-0xfbffffff] 
(64MB) from e820 map
[ 0.000000] e820: remove [mem 0xf8000000-0xfbffffff] reserved
[ 0.000000] efi: Remove mem272: MMIO range=[0xfd000000-0xffffffff] 
(48MB) from e820 map
[ 0.000000] e820: remove [mem 0xfd000000-0xffffffff] reserved
[ 0.000000] SMBIOS 3.2.1 present.
[ 0.000000] DMI: To Be Filled By O.E.M. To Be Filled By O.E.M./B450 
Gaming-ITX/ac, BIOS P3.40 07/17/2019
[ 0.000000] DMI: Memory slots populated: 2/2
[ 0.000000] tsc: Fast TSC calibration using PIT
[ 0.000000] tsc: Detected 3899.993 MHz processor
[ 0.000452] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[ 0.000454] e820: remove [mem 0x000a0000-0x000fffff] usable
[ 0.000460] last_pfn = 0x21f340 max_arch_pfn = 0x400000000
[ 0.000464] MTRR map: 5 entries (3 fixed + 2 variable; max 20), built 
from 9 variable MTRRs
[ 0.000465] x86/PAT: Configuration [0-7]: WB WC UC- UC WB WP UC- WT
[ 0.000593] e820: update [mem 0xe0000000-0xffffffff] usable ==> reserved
[ 0.000611] last_pfn = 0x5f000 max_arch_pfn = 0x400000000
[ 0.003797] esrt: Reserving ESRT space from 0x0000000059e4ae18 to 
0x0000000059e4ae50.
[ 0.003808] e820: update [mem 0x59e4a000-0x59e4afff] usable ==> reserved
[ 0.003841] Using GB pages for direct mapping
[ 0.004213] Secure boot disabled
[ 0.004215] ACPI: Early table checksum verification disabled
[ 0.004217] ACPI: RSDP 0x000000005C8BB000 000024 (v02 ALASKA)
[ 0.004220] ACPI: XSDT 0x000000005C8BB0A0 0000BC (v01 ALASKA A M I 
01072009 AMI 00010013)
[ 0.004224] ACPI: FACP 0x000000005C8C1BB8 000114 (v06 ALASKA A M I 
01072009 AMI 00010013)
[ 0.004227] ACPI: DSDT 0x000000005C8BB1F0 0069C1 (v02 ALASKA A M I 
01072009 INTL 20120913)
[ 0.004229] ACPI: FACS 0x000000005C927E00 000040
[ 0.004231] ACPI: APIC 0x000000005C8C1CD0 00015E (v03 ALASKA A M I 
01072009 AMI 00010013)
[ 0.004233] ACPI: FPDT 0x000000005C8C1E30 000044 (v01 ALASKA A M I 
01072009 AMI 00010013)
[ 0.004235] ACPI: FIDT 0x000000005C8C1E78 00009C (v01 ALASKA A M I 
01072009 AMI 00010013)
[ 0.004237] ACPI: SSDT 0x000000005C8C1F18 000094 (v02 ALASKA CPUSSDT 
01072009 AMI 01072009)
[ 0.004239] ACPI: SSDT 0x000000005C8C1FB0 005419 (v02 AMD AmdTable 
00000002 MSFT 02000002)
[ 0.004240] ACPI: SSDT 0x000000005C8C73D0 00315B (v01 AMD AMD AOD 
00000001 INTL 20120913)
[ 0.004242] ACPI: MCFG 0x000000005C8CA530 00003C (v01 ALASKA A M I 
01072009 MSFT 00010013)
[ 0.004244] ACPI: AAFT 0x000000005C8CA570 000440 (v01 ALASKA OEMAAFT 
01072009 MSFT 00000097)
[ 0.004246] ACPI: HPET 0x000000005C8CA9B0 000038 (v01 ALASKA A M I 
01072009 AMI 00000005)
[ 0.004248] ACPI: UEFI 0x000000005C8CA9E8 000042 (v01 ALASKA A M I 
00000002 01000013)
[ 0.004250] ACPI: BGRT 0x000000005C8CAA30 000038 (v01 ALASKA A M I 
01072009 AMI 00010013)
[ 0.004252] ACPI: SSDT 0x000000005C8CAA68 000E0C (v01 AMD AMD CPU 
00000001 AMD 00000001)
[ 0.004254] ACPI: CRAT 0x000000005C8CB878 000810 (v01 AMD AMD CRAT 
00000001 AMD 00000001)
[ 0.004255] ACPI: CDIT 0x000000005C8CC088 000029 (v01 AMD AMD CDIT 
00000001 AMD 00000001)
[ 0.004257] ACPI: SSDT 0x000000005C8CC0B8 001D34 (v01 AMD AmdTable 
00000001 INTL 20120913)
[ 0.004259] ACPI: SSDT 0x000000005C8CDDF0 0000BF (v01 AMD AMD PT 
00001000 INTL 20120913)
[ 0.004261] ACPI: WSMT 0x000000005C8CDEB0 000028 (v01 ALASKA A M I 
01072009 AMI 00010013)
[ 0.004263] ACPI: SSDT 0x000000005C8CDED8 0010AF (v01 AMD AmdTable 
00000001 INTL 20120913)
[ 0.004264] ACPI: Reserving FACP table memory at [mem 
0x5c8c1bb8-0x5c8c1ccb]
[ 0.004265] ACPI: Reserving DSDT table memory at [mem 
0x5c8bb1f0-0x5c8c1bb0]
[ 0.004266] ACPI: Reserving FACS table memory at [mem 
0x5c927e00-0x5c927e3f]
[ 0.004267] ACPI: Reserving APIC table memory at [mem 
0x5c8c1cd0-0x5c8c1e2d]
[ 0.004267] ACPI: Reserving FPDT table memory at [mem 
0x5c8c1e30-0x5c8c1e73]
[ 0.004268] ACPI: Reserving FIDT table memory at [mem 
0x5c8c1e78-0x5c8c1f13]
[ 0.004269] ACPI: Reserving SSDT table memory at [mem 
0x5c8c1f18-0x5c8c1fab]
[ 0.004269] ACPI: Reserving SSDT table memory at [mem 
0x5c8c1fb0-0x5c8c73c8]
[ 0.004270] ACPI: Reserving SSDT table memory at [mem 
0x5c8c73d0-0x5c8ca52a]
[ 0.004271] ACPI: Reserving MCFG table memory at [mem 
0x5c8ca530-0x5c8ca56b]
[ 0.004271] ACPI: Reserving AAFT table memory at [mem 
0x5c8ca570-0x5c8ca9af]
[ 0.004272] ACPI: Reserving HPET table memory at [mem 
0x5c8ca9b0-0x5c8ca9e7]
[ 0.004272] ACPI: Reserving UEFI table memory at [mem 
0x5c8ca9e8-0x5c8caa29]
[ 0.004273] ACPI: Reserving BGRT table memory at [mem 
0x5c8caa30-0x5c8caa67]
[ 0.004274] ACPI: Reserving SSDT table memory at [mem 
0x5c8caa68-0x5c8cb873]
[ 0.004274] ACPI: Reserving CRAT table memory at [mem 
0x5c8cb878-0x5c8cc087]
[ 0.004275] ACPI: Reserving CDIT table memory at [mem 
0x5c8cc088-0x5c8cc0b0]
[ 0.004275] ACPI: Reserving SSDT table memory at [mem 
0x5c8cc0b8-0x5c8cddeb]
[ 0.004276] ACPI: Reserving SSDT table memory at [mem 
0x5c8cddf0-0x5c8cdeae]
[ 0.004277] ACPI: Reserving WSMT table memory at [mem 
0x5c8cdeb0-0x5c8cded7]
[ 0.004277] ACPI: Reserving SSDT table memory at [mem 
0x5c8cded8-0x5c8cef86]
[ 0.004352] No NUMA configuration found
[ 0.004352] Faking a node at [mem 0x0000000000000000-0x000000021f33ffff]
[ 0.004355] NODE_DATA(0) allocated [mem 0x21f33c940-0x21f33ffff]
[ 0.004368] Zone ranges:
[ 0.004368] DMA [mem 0x0000000000001000-0x0000000000ffffff]
[ 0.004369] DMA32 [mem 0x0000000001000000-0x00000000ffffffff]
[ 0.004370] Normal [mem 0x0000000100000000-0x000000021f33ffff]
[ 0.004371] Movable zone start for each node
[ 0.004372] Early memory node ranges
[ 0.004372] node 0: [mem 0x0000000000001000-0x000000000009ffff]
[ 0.004373] node 0: [mem 0x0000000000100000-0x0000000009d01fff]
[ 0.004374] node 0: [mem 0x000000000a000000-0x000000000a1fffff]
[ 0.004375] node 0: [mem 0x000000000a20b000-0x000000000affffff]
[ 0.004375] node 0: [mem 0x000000000b020000-0x000000005aed0fff]
[ 0.004376] node 0: [mem 0x000000005d75f000-0x000000005effffff]
[ 0.004376] node 0: [mem 0x0000000100000000-0x000000021f33ffff]
[ 0.004378] Initmem setup node 0 [mem 
0x0000000000001000-0x000000021f33ffff]
[ 0.004381] On node 0, zone DMA: 1 pages in unavailable ranges
[ 0.004402] On node 0, zone DMA: 96 pages in unavailable ranges
[ 0.004586] On node 0, zone DMA32: 766 pages in unavailable ranges
[ 0.004605] On node 0, zone DMA32: 11 pages in unavailable ranges
[ 0.006604] On node 0, zone DMA32: 32 pages in unavailable ranges
[ 0.006737] On node 0, zone DMA32: 10382 pages in unavailable ranges
[ 0.014182] On node 0, zone Normal: 4096 pages in unavailable ranges
[ 0.014214] On node 0, zone Normal: 3264 pages in unavailable ranges
[ 0.015021] ACPI: PM-Timer IO Port: 0x808
[ 0.015027] CPU topo: Ignoring hot-pluggable APIC ID 0 in present 
package.
[ 0.015030] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[ 0.015049] IOAPIC[0]: apic_id 9, version 33, address 0xfec00000, GSI 
0-23
[ 0.015060] IOAPIC[1]: apic_id 10, version 33, address 0xfec01000, GSI 
24-55
[ 0.015062] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[ 0.015063] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[ 0.015066] ACPI: Using ACPI (MADT) for SMP configuration information
[ 0.015066] ACPI: HPET id: 0x10228201 base: 0xfed00000
[ 0.015079] e820: update [mem 0x57754000-0x57794fff] usable ==> reserved
[ 0.015091] CPU topo: Max. logical packages: 1
[ 0.015092] CPU topo: Max. logical dies: 1
[ 0.015092] CPU topo: Max. dies per package: 1
[ 0.015096] CPU topo: Max. threads per core: 2
[ 0.015097] CPU topo: Num. cores per package: 4
[ 0.015097] CPU topo: Num. threads per package: 8
[ 0.015097] CPU topo: Allowing 8 present CPUs plus 0 hotplug CPUs
[ 0.015098] CPU topo: Rejected CPUs 24
[ 0.015110] PM: hibernation: Registered nosave memory: [mem 
0x00000000-0x00000fff]
[ 0.015112] PM: hibernation: Registered nosave memory: [mem 
0x000a0000-0x000fffff]
[ 0.015113] PM: hibernation: Registered nosave memory: [mem 
0x09d02000-0x09ffffff]
[ 0.015114] PM: hibernation: Registered nosave memory: [mem 
0x0a200000-0x0a20afff]
[ 0.015115] PM: hibernation: Registered nosave memory: [mem 
0x0b000000-0x0b01ffff]
[ 0.015116] PM: hibernation: Registered nosave memory: [mem 
0x57084000-0x57084fff]
[ 0.015117] PM: hibernation: Registered nosave memory: [mem 
0x57091000-0x57091fff]
[ 0.015118] PM: hibernation: Registered nosave memory: [mem 
0x57754000-0x57794fff]
[ 0.015120] PM: hibernation: Registered nosave memory: [mem 
0x59e4a000-0x59e4afff]
[ 0.015121] PM: hibernation: Registered nosave memory: [mem 
0x5aed1000-0x5c3affff]
[ 0.015121] PM: hibernation: Registered nosave memory: [mem 
0x5c3b0000-0x5c42cfff]
[ 0.015122] PM: hibernation: Registered nosave memory: [mem 
0x5c42d000-0x5c93efff]
[ 0.015122] PM: hibernation: Registered nosave memory: [mem 
0x5c93f000-0x5d75efff]
[ 0.015124] PM: hibernation: Registered nosave memory: [mem 
0x5f000000-0xdfffffff]
[ 0.015124] PM: hibernation: Registered nosave memory: [mem 
0xe0000000-0xffffffff]
[ 0.015125] [mem 0xe0000000-0xffffffff] available for PCI devices
[ 0.015128] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 1910969940391419 ns
[ 0.021054] setup_percpu: NR_CPUS:64 nr_cpumask_bits:8 nr_cpu_ids:8 
nr_node_ids:1
[ 0.021302] percpu: Embedded 56 pages/cpu s191256 r8192 d29928 u262144
[ 0.021307] pcpu-alloc: s191256 r8192 d29928 u262144 alloc=1*2097152
[ 0.021309] pcpu-alloc: [0] 0 1 2 3 4 5 6 7
[ 0.021323] Kernel command line: 
BOOT_IMAGE=/boot/vmlinuz-6.13.4-lfs-12.3 root=/dev/nvme0n1p5 ro
[ 0.021342] Unknown kernel command line parameters 
"BOOT_IMAGE=/boot/vmlinuz-6.13.4-lfs-12.3", will be passed to user 
space.
[ 0.021569] printk: log buffer data + meta data: 262144 + 917504 = 
1179648 bytes
[ 0.022253] Dentry cache hash table entries: 1048576 (order: 11, 
8388608 bytes, linear)
[ 0.022635] Inode-cache hash table entries: 524288 (order: 10, 4194304 
bytes, linear)
[ 0.022677] Fallback order for Node 0: 0
[ 0.022681] Built 1 zonelists, mobility grouping on. Total pages: 
1554216
[ 0.022682] Policy zone: Normal
[ 0.022683] mem auto-init: stack:all(zero), heap alloc:off, heap 
free:off
[ 0.022687] software IO TLB: area num 8.
[ 0.042989] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[ 0.043743] Dynamic Preempt: voluntary
[ 0.043772] rcu: Preemptible hierarchical RCU implementation.
[ 0.043773] rcu: RCU event tracing is enabled.
[ 0.043773] rcu: RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=8.
[ 0.043774] Trampoline variant of Tasks RCU enabled.
[ 0.043775] Tracing variant of Tasks RCU enabled.
[ 0.043775] rcu: RCU calculated value of scheduler-enlistment delay is 
100 jiffies.
[ 0.043776] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[ 0.043782] RCU Tasks: Setting shift to 3 and lim to 1 
rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
[ 0.043783] RCU Tasks Trace: Setting shift to 3 and lim to 1 
rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
[ 0.046980] NR_IRQS: 4352, nr_irqs: 1032, preallocated irqs: 16
[ 0.047175] rcu: srcu_init: Setting srcu_struct sizes based on 
contention.
[ 0.047306] Console: colour dummy device 80x25
[ 0.047308] printk: legacy console [tty0] enabled
[ 0.047586] ACPI: Core revision 20240827
[ 0.047685] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, 
max_idle_ns: 133484873504 ns
[ 0.047717] APIC: Switch to symmetric I/O mode setup
[ 0.049086] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[ 0.053721] clocksource: tsc-early: mask: 0xffffffffffffffff 
max_cycles: 0x706ea736fba, max_idle_ns: 881590561909 ns
[ 0.053727] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 7799.98 BogoMIPS (lpj=3899993)
[ 0.053739] AMD Zen1 DIV0 bug detected. Disable SMT for full protection.
[ 0.053861] LVT offset 1 assigned for vector 0xf9
[ 0.053900] LVT offset 2 assigned for vector 0xf4
[ 0.053913] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[ 0.053915] Last level dTLB entries: 4KB 1536, 2MB 1536, 4MB 768, 1GB 0
[ 0.053919] process: using mwait in idle threads
[ 0.053921] Spectre V1 : Mitigation: usercopy/swapgs barriers and 
__user pointer sanitization
[ 0.053924] Spectre V2 : Mitigation: Retpolines
[ 0.053926] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling 
RSB on context switch
[ 0.053928] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[ 0.053930] Spectre V2 : Enabling Speculation Barrier for firmware calls
[ 0.053932] RETBleed: Mitigation: untrained return thunk
[ 0.053934] Spectre V2 : mitigation: Enabling conditional Indirect 
Branch Prediction Barrier
[ 0.053937] Speculative Store Bypass: Mitigation: Speculative Store 
Bypass disabled via prctl
[ 0.053940] Speculative Return Stack Overflow: Mitigation: Safe RET
[ 0.053944] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating 
point registers'
[ 0.053947] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[ 0.053949] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[ 0.053951] x86/fpu: xstate_offset[2]: 576, xstate_sizes[2]: 256
[ 0.053954] x86/fpu: Enabled xstate features 0x7, context size is 832 
bytes, using 'compacted' format.
[ 0.074162] Freeing SMP alternatives memory: 44K
[ 0.074171] pid_max: default: 32768 minimum: 301
[ 0.076755] LSM: initializing lsm=capability,selinux
[ 0.076785] SELinux: Initializing.
[ 0.076984] Mount-cache hash table entries: 16384 (order: 5, 131072 
bytes, linear)
[ 0.076999] Mountpoint-cache hash table entries: 16384 (order: 5, 
131072 bytes, linear)
[ 0.179895] smpboot: CPU0: AMD Ryzen 5 2400G with Radeon Vega Graphics 
(family: 0x17, model: 0x11, stepping: 0x0)
[ 0.180097] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[ 0.180123] ... version: 0
[ 0.180127] ... bit width: 48
[ 0.180131] ... generic registers: 6
[ 0.180135] ... value mask: 0000ffffffffffff
[ 0.180139] ... max period: 00007fffffffffff
[ 0.180144] ... fixed-purpose events: 0
[ 0.180148] ... event mask: 000000000000003f
[ 0.180238] signal: max sigframe size: 1776
[ 0.180268] rcu: Hierarchical SRCU implementation.
[ 0.180272] rcu: Max phase no-delay instances is 400.
[ 0.180318] Timer migration: 1 hierarchy levels; 8 children per group; 
1 crossnode level
[ 0.184717] smp: Bringing up secondary CPUs ...
[ 0.184812] smpboot: x86: Booting SMP configuration:
[ 0.184817] .... node #0, CPUs: #1 #2 #3 #4 #5 #6 #7
[ 0.193741] smp: Brought up 1 node, 8 CPUs
[ 0.193750] smpboot: Total of 8 processors activated (62399.88 BogoMIPS)
[ 0.194470] Memory: 5982600K/6216864K available (22528K kernel code, 
3041K rwdata, 11360K rodata, 2932K init, 1880K bss, 228952K reserved, 
0K cma-reserved)
[ 0.195005] devtmpfs: initialized
[ 0.195256] ACPI: PM: Registering ACPI NVS region [mem 
0x0a200000-0x0a20afff] (45056 bytes)
[ 0.195256] ACPI: PM: Registering ACPI NVS region [mem 
0x5c42d000-0x5c93efff] (5316608 bytes)
[ 0.195256] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 1911260446275000 ns
[ 0.195732] futex hash table entries: 2048 (order: 5, 131072 bytes, 
linear)
[ 0.195764] pinctrl core: initialized pinctrl subsystem
[ 0.195834] PM: RTC time: 18:06:59, date: 2025-05-08
[ 0.195920] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[ 0.196072] audit: initializing netlink subsys (disabled)
[ 0.196105] audit: type=2000 audit(1746727619.148:1): state=initialized 
audit_enabled=0 res=1
[ 0.196177] thermal_sys: Registered thermal governor 'step_wise'
[ 0.196179] thermal_sys: Registered thermal governor 'user_space'
[ 0.196194] cpuidle: using governor menu
[ 0.196233] PCI: ECAM [mem 0xf8000000-0xfbffffff] (base 0xf8000000) for 
domain 0000 [bus 00-3f]
[ 0.196233] PCI: Using configuration type 1 for base access
[ 0.196233] kprobes: kprobe jump-optimization is enabled. All kprobes 
are optimized if possible.
[ 0.196233] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 
pages
[ 0.196233] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[ 0.196789] ACPI: Added _OSI(Module Device)
[ 0.196795] ACPI: Added _OSI(Processor Device)
[ 0.196799] ACPI: Added _OSI(3.0 _SCP Extensions)
[ 0.196804] ACPI: Added _OSI(Processor Aggregator Device)
[ 0.207261] ACPI: 8 ACPI AML tables successfully acquired and loaded
[ 0.209104] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[ 0.211334] ACPI: Interpreter enabled
[ 0.211355] ACPI: PM: (supports S0 S3 S4 S5)
[ 0.211360] ACPI: Using IOAPIC for interrupt routing
[ 0.211853] PCI: Using host bridge windows from ACPI; if necessary, use 
"pci=nocrs" and report a bug
[ 0.211861] PCI: Using E820 reservations for host bridge windows
[ 0.212260] ACPI: Enabled 2 GPEs in block 00 to 1F
[ 0.224149] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[ 0.224160] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM 
ClockPM Segments MSI HPX-Type3]
[ 0.224257] acpi PNP0A08:00: _OSC: platform does not support [LTR]
[ 0.224429] acpi PNP0A08:00: _OSC: OS now controls [PME PCIeCapability]
[ 0.224443] acpi PNP0A08:00: [Firmware Info]: ECAM [mem 
0xf8000000-0xfbffffff] for domain 0000 [bus 00-3f] only partially 
covers this bridge
[ 0.224783] PCI host bridge to bus 0000:00
[ 0.224790] pci_bus 0000:00: root bus resource [io 0x0000-0x03af window]
[ 0.224797] pci_bus 0000:00: root bus resource [io 0x03e0-0x0cf7 window]
[ 0.224803] pci_bus 0000:00: root bus resource [io 0x03b0-0x03df window]
[ 0.224810] pci_bus 0000:00: root bus resource [io 0x0d00-0xffff window]
[ 0.224816] pci_bus 0000:00: root bus resource [mem 
0x000a0000-0x000dffff window]
[ 0.224823] pci_bus 0000:00: root bus resource [mem 
0xe0000000-0xfec2ffff window]
[ 0.224830] pci_bus 0000:00: root bus resource [mem 
0xfee00000-0xffffffff window]
[ 0.224837] pci_bus 0000:00: root bus resource [bus 00-ff]
[ 0.224859] pci 0000:00:00.0: [1022:15d0] type 00 class 0x060000 
conventional PCI endpoint
[ 0.225022] pci 0000:00:01.0: [1022:1452] type 00 class 0x060000 
conventional PCI endpoint
[ 0.225142] pci 0000:00:01.1: [1022:15d3] type 01 class 0x060400 PCIe 
Root Port
[ 0.225179] pci 0000:00:01.1: PCI bridge to [bus 01-04]
[ 0.225192] pci 0000:00:01.1: bridge window [mem 0xfc200000-0xfc5fffff]
[ 0.225218] pci 0000:00:01.1: enabling Extended Tags
[ 0.225297] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[ 0.225536] pci 0000:00:01.2: [1022:15d3] type 01 class 0x060400 PCIe 
Root Port
[ 0.225573] pci 0000:00:01.2: PCI bridge to [bus 05-0c]
[ 0.225584] pci 0000:00:01.2: bridge window [io 0xf000-0xffff]
[ 0.225592] pci 0000:00:01.2: bridge window [mem 0xfca00000-0xfccfffff]
[ 0.225618] pci 0000:00:01.2: enabling Extended Tags
[ 0.225696] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[ 0.225966] pci 0000:00:01.6: [1022:15d3] type 01 class 0x060400 PCIe 
Root Port
[ 0.226003] pci 0000:00:01.6: PCI bridge to [bus 0d]
[ 0.226015] pci 0000:00:01.6: bridge window [mem 0xfce00000-0xfcefffff]
[ 0.226042] pci 0000:00:01.6: enabling Extended Tags
[ 0.226119] pci 0000:00:01.6: PME# supported from D0 D3hot D3cold
[ 0.226346] pci 0000:00:08.0: [1022:1452] type 00 class 0x060000 
conventional PCI endpoint
[ 0.226474] pci 0000:00:08.1: [1022:15db] type 01 class 0x060400 PCIe 
Root Port
[ 0.226514] pci 0000:00:08.1: PCI bridge to [bus 0e]
[ 0.226525] pci 0000:00:08.1: bridge window [io 0xe000-0xefff]
[ 0.226533] pci 0000:00:08.1: bridge window [mem 0xfc600000-0xfc9fffff]
[ 0.226549] pci 0000:00:08.1: bridge window [mem 0xe0000000-0xf01fffff 
64bit pref]
[ 0.226568] pci 0000:00:08.1: enabling Extended Tags
[ 0.226641] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[ 0.226893] pci 0000:00:08.2: [1022:15dc] type 01 class 0x060400 PCIe 
Root Port
[ 0.226933] pci 0000:00:08.2: PCI bridge to [bus 0f]
[ 0.226946] pci 0000:00:08.2: bridge window [mem 0xfcd00000-0xfcdfffff]
[ 0.226974] pci 0000:00:08.2: enabling Extended Tags
[ 0.227053] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
[ 0.227313] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 
conventional PCI endpoint
[ 0.227516] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 
conventional PCI endpoint
[ 0.227731] pci 0000:00:18.0: [1022:15e8] type 00 class 0x060000 
conventional PCI endpoint
[ 0.227788] pci 0000:00:18.1: [1022:15e9] type 00 class 0x060000 
conventional PCI endpoint
[ 0.227840] pci 0000:00:18.2: [1022:15ea] type 00 class 0x060000 
conventional PCI endpoint
[ 0.227892] pci 0000:00:18.3: [1022:15eb] type 00 class 0x060000 
conventional PCI endpoint
[ 0.227943] pci 0000:00:18.4: [1022:15ec] type 00 class 0x060000 
conventional PCI endpoint
[ 0.227995] pci 0000:00:18.5: [1022:15ed] type 00 class 0x060000 
conventional PCI endpoint
[ 0.228046] pci 0000:00:18.6: [1022:15ee] type 00 class 0x060000 
conventional PCI endpoint
[ 0.228097] pci 0000:00:18.7: [1022:15ef] type 00 class 0x060000 
conventional PCI endpoint
[ 0.228228] pci 0000:01:00.0: [12d8:2304] type 01 class 0x060400 PCIe 
Switch Upstream Port
[ 0.228268] pci 0000:01:00.0: PCI bridge to [bus 02-04]
[ 0.228282] pci 0000:01:00.0: bridge window [mem 0xfc200000-0xfc5fffff]
[ 0.228401] pci 0000:01:00.0: supports D1 D2
[ 0.228406] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[ 0.228450] pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, 
limited by 5.0 GT/s PCIe x1 link at 0000:00:01.1 (capable of 8.000 Gb/s 
with 5.0 GT/s PCIe x2 link)
[ 0.228580] pci 0000:00:01.1: PCI bridge to [bus 01-04]
[ 0.228665] pci 0000:02:01.0: [12d8:2304] type 01 class 0x060400 PCIe 
Switch Downstream Port
[ 0.228705] pci 0000:02:01.0: PCI bridge to [bus 03]
[ 0.228719] pci 0000:02:01.0: bridge window [mem 0xfc400000-0xfc5fffff]
[ 0.228839] pci 0000:02:01.0: supports D1 D2
[ 0.228843] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[ 0.228991] pci 0000:02:02.0: [12d8:2304] type 01 class 0x060400 PCIe 
Switch Downstream Port
[ 0.229031] pci 0000:02:02.0: PCI bridge to [bus 04]
[ 0.229044] pci 0000:02:02.0: bridge window [mem 0xfc200000-0xfc3fffff]
[ 0.229162] pci 0000:02:02.0: supports D1 D2
[ 0.229167] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[ 0.229326] pci 0000:01:00.0: PCI bridge to [bus 02-04]
[ 0.229419] pci 0000:03:00.0: [14f1:8880] type 00 class 0x040000 PCIe 
Endpoint
[ 0.229459] pci 0000:03:00.0: BAR 0 [mem 0xfc400000-0xfc5fffff 64bit]
[ 0.229650] pci 0000:03:00.0: supports D1 D2
[ 0.229654] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[ 0.229803] pci 0000:02:01.0: PCI bridge to [bus 03]
[ 0.229899] pci 0000:04:00.0: [14f1:8880] type 00 class 0x040000 PCIe 
Endpoint
[ 0.229939] pci 0000:04:00.0: BAR 0 [mem 0xfc200000-0xfc3fffff 64bit]
[ 0.230130] pci 0000:04:00.0: supports D1 D2
[ 0.230135] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[ 0.230281] pci 0000:02:02.0: PCI bridge to [bus 04]
[ 0.230387] pci 0000:05:00.0: [1022:43d5] type 00 class 0x0c0330 PCIe 
Legacy Endpoint
[ 0.230416] pci 0000:05:00.0: BAR 0 [mem 0xfcca0000-0xfcca7fff 64bit]
[ 0.230470] pci 0000:05:00.0: enabling Extended Tags
[ 0.230547] pci 0000:05:00.0: PME# supported from D3hot D3cold
[ 0.230727] pci 0000:05:00.1: [1022:43c8] type 00 class 0x010601 PCIe 
Legacy Endpoint
[ 0.230792] pci 0000:05:00.1: BAR 5 [mem 0xfcc80000-0xfcc9ffff]
[ 0.230806] pci 0000:05:00.1: ROM [mem 0xfcc00000-0xfcc7ffff pref]
[ 0.230820] pci 0000:05:00.1: enabling Extended Tags
[ 0.230876] pci 0000:05:00.1: PME# supported from D3hot D3cold
[ 0.230999] pci 0000:05:00.2: [1022:43c6] type 01 class 0x060400 PCIe 
Switch Upstream Port
[ 0.231041] pci 0000:05:00.2: PCI bridge to [bus 06-0c]
[ 0.231052] pci 0000:05:00.2: bridge window [io 0xf000-0xffff]
[ 0.231060] pci 0000:05:00.2: bridge window [mem 0xfca00000-0xfcbfffff]
[ 0.231092] pci 0000:05:00.2: enabling Extended Tags
[ 0.231154] pci 0000:05:00.2: PME# supported from D3hot D3cold
[ 0.231327] pci 0000:00:01.2: PCI bridge to [bus 05-0c]
[ 0.231407] pci 0000:06:00.0: [1022:43c7] type 01 class 0x060400 PCIe 
Switch Downstream Port
[ 0.231450] pci 0000:06:00.0: PCI bridge to [bus 07]
[ 0.231491] pci 0000:06:00.0: enabling Extended Tags
[ 0.231574] pci 0000:06:00.0: PME# supported from D3hot D3cold
[ 0.231728] pci 0000:06:01.0: [1022:43c7] type 01 class 0x060400 PCIe 
Switch Downstream Port
[ 0.231771] pci 0000:06:01.0: PCI bridge to [bus 08]
[ 0.231812] pci 0000:06:01.0: enabling Extended Tags
[ 0.231896] pci 0000:06:01.0: PME# supported from D3hot D3cold
[ 0.232047] pci 0000:06:04.0: [1022:43c7] type 01 class 0x060400 PCIe 
Switch Downstream Port
[ 0.232089] pci 0000:06:04.0: PCI bridge to [bus 09]
[ 0.232131] pci 0000:06:04.0: enabling Extended Tags
[ 0.232214] pci 0000:06:04.0: PME# supported from D3hot D3cold
[ 0.232363] pci 0000:06:05.0: [1022:43c7] type 01 class 0x060400 PCIe 
Switch Downstream Port
[ 0.232406] pci 0000:06:05.0: PCI bridge to [bus 0a]
[ 0.232448] pci 0000:06:05.0: enabling Extended Tags
[ 0.232531] pci 0000:06:05.0: PME# supported from D3hot D3cold
[ 0.232683] pci 0000:06:06.0: [1022:43c7] type 01 class 0x060400 PCIe 
Switch Downstream Port
[ 0.232727] pci 0000:06:06.0: PCI bridge to [bus 0b]
[ 0.232741] pci 0000:06:06.0: bridge window [mem 0xfcb00000-0xfcbfffff]
[ 0.232774] pci 0000:06:06.0: enabling Extended Tags
[ 0.232858] pci 0000:06:06.0: PME# supported from D3hot D3cold
[ 0.233010] pci 0000:06:07.0: [1022:43c7] type 01 class 0x060400 PCIe 
Switch Downstream Port
[ 0.233052] pci 0000:06:07.0: PCI bridge to [bus 0c]
[ 0.233064] pci 0000:06:07.0: bridge window [io 0xf000-0xffff]
[ 0.233072] pci 0000:06:07.0: bridge window [mem 0xfca00000-0xfcafffff]
[ 0.233106] pci 0000:06:07.0: enabling Extended Tags
[ 0.233189] pci 0000:06:07.0: PME# supported from D3hot D3cold
[ 0.233348] pci 0000:05:00.2: PCI bridge to [bus 06-0c]
[ 0.233410] pci 0000:06:00.0: PCI bridge to [bus 07]
[ 0.233474] pci 0000:06:01.0: PCI bridge to [bus 08]
[ 0.233538] pci 0000:06:04.0: PCI bridge to [bus 09]
[ 0.233600] pci 0000:06:05.0: PCI bridge to [bus 0a]
[ 0.233727] pci 0000:0b:00.0: [8086:24fb] type 00 class 0x028000 PCIe 
Endpoint
[ 0.233781] pci 0000:0b:00.0: BAR 0 [mem 0xfcb00000-0xfcb01fff 64bit]
[ 0.234051] pci 0000:0b:00.0: PME# supported from D0 D3hot D3cold
[ 0.234344] pci 0000:06:06.0: PCI bridge to [bus 0b]
[ 0.234461] pci 0000:0c:00.0: [8086:1539] type 00 class 0x020000 PCIe 
Endpoint
[ 0.234502] pci 0000:0c:00.0: BAR 0 [mem 0xfca00000-0xfca1ffff]
[ 0.234545] pci 0000:0c:00.0: BAR 2 [io 0xf000-0xf01f]
[ 0.234568] pci 0000:0c:00.0: BAR 3 [mem 0xfca20000-0xfca23fff]
[ 0.234789] pci 0000:0c:00.0: PME# supported from D0 D3hot D3cold
[ 0.234998] pci 0000:06:07.0: PCI bridge to [bus 0c]
[ 0.235133] pci 0000:0d:00.0: [126f:2262] type 00 class 0x010802 PCIe 
Endpoint
[ 0.235164] pci 0000:0d:00.0: BAR 0 [mem 0xfce00000-0xfce03fff 64bit]
[ 0.235473] pci 0000:00:01.6: PCI bridge to [bus 0d]
[ 0.235568] pci 0000:0e:00.0: [1002:15dd] type 00 class 0x030000 PCIe 
Legacy Endpoint
[ 0.235602] pci 0000:0e:00.0: BAR 0 [mem 0xe0000000-0xefffffff 64bit 
pref]
[ 0.235626] pci 0000:0e:00.0: BAR 2 [mem 0xf0000000-0xf01fffff 64bit 
pref]
[ 0.235643] pci 0000:0e:00.0: BAR 4 [io 0xe000-0xe0ff]
[ 0.235659] pci 0000:0e:00.0: BAR 5 [mem 0xfc900000-0xfc97ffff]
[ 0.235684] pci 0000:0e:00.0: enabling Extended Tags
[ 0.235733] pci 0000:0e:00.0: Video device with shadowed ROM at [mem 
0x000c0000-0x000dffff]
[ 0.235843] pci 0000:0e:00.0: PME# supported from D1 D2 D3hot D3cold
[ 0.236062] pci 0000:0e:00.1: [1002:15de] type 00 class 0x040300 PCIe 
Legacy Endpoint
[ 0.236089] pci 0000:0e:00.1: BAR 0 [mem 0xfc988000-0xfc98bfff]
[ 0.236166] pci 0000:0e:00.1: enabling Extended Tags
[ 0.236242] pci 0000:0e:00.1: PME# supported from D1 D2 D3hot D3cold
[ 0.236384] pci 0000:0e:00.2: [1022:15df] type 00 class 0x108000 PCIe 
Endpoint
[ 0.236432] pci 0000:0e:00.2: BAR 2 [mem 0xfc800000-0xfc8fffff]
[ 0.236469] pci 0000:0e:00.2: BAR 5 [mem 0xfc98c000-0xfc98dfff]
[ 0.236493] pci 0000:0e:00.2: enabling Extended Tags
[ 0.236703] pci 0000:0e:00.3: [1022:15e0] type 00 class 0x0c0330 PCIe 
Endpoint
[ 0.236737] pci 0000:0e:00.3: BAR 0 [mem 0xfc700000-0xfc7fffff 64bit]
[ 0.236804] pci 0000:0e:00.3: enabling Extended Tags
[ 0.236886] pci 0000:0e:00.3: PME# supported from D0 D3hot D3cold
[ 0.237047] pci 0000:0e:00.4: [1022:15e1] type 00 class 0x0c0330 PCIe 
Endpoint
[ 0.237079] pci 0000:0e:00.4: BAR 0 [mem 0xfc600000-0xfc6fffff 64bit]
[ 0.237145] pci 0000:0e:00.4: enabling Extended Tags
[ 0.237228] pci 0000:0e:00.4: PME# supported from D0 D3hot D3cold
[ 0.237373] pci 0000:0e:00.6: [1022:15e3] type 00 class 0x040300 PCIe 
Endpoint
[ 0.237400] pci 0000:0e:00.6: BAR 0 [mem 0xfc980000-0xfc987fff]
[ 0.237476] pci 0000:0e:00.6: enabling Extended Tags
[ 0.237553] pci 0000:0e:00.6: PME# supported from D0 D3hot D3cold
[ 0.237729] pci 0000:00:08.1: PCI bridge to [bus 0e]
[ 0.237824] pci 0000:0f:00.0: [1022:7901] type 00 class 0x010601 PCIe 
Endpoint
[ 0.237903] pci 0000:0f:00.0: BAR 5 [mem 0xfcd00000-0xfcd007ff]
[ 0.237927] pci 0000:0f:00.0: enabling Extended Tags
[ 0.238032] pci 0000:0f:00.0: PME# supported from D3hot D3cold
[ 0.238225] pci 0000:00:08.2: PCI bridge to [bus 0f]
[ 0.238795] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[ 0.238860] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[ 0.238916] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[ 0.238985] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[ 0.239047] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[ 0.239099] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[ 0.239151] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[ 0.239204] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[ 0.241067] iommu: Default domain type: Translated
[ 0.241073] iommu: DMA domain TLB invalidation policy: lazy mode
[ 0.241143] SCSI subsystem initialized
[ 0.241155] libata version 3.00 loaded.
[ 0.241155] ACPI: bus type USB registered
[ 0.241155] usbcore: registered new interface driver usbfs
[ 0.241155] usbcore: registered new interface driver hub
[ 0.241155] usbcore: registered new device driver usb
[ 0.241155] pps_core: LinuxPPS API ver. 1 registered
[ 0.241155] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo 
Giometti <giometti@linux.it>
[ 0.241155] PTP clock support registered
[ 0.241155] efivars: Registered efivars operations
[ 0.241155] Advanced Linux Sound Architecture Driver Initialized.
[ 0.241814] NetLabel: Initializing
[ 0.241818] NetLabel: domain hash size = 128
[ 0.241823] NetLabel: protocols = UNLABELED CIPSOv4 CALIPSO
[ 0.241848] NetLabel: unlabeled traffic allowed by default
[ 0.241869] PCI: Using ACPI for IRQ routing
[ 0.244544] PCI: pci_cache_line_size set to 64 bytes
[ 0.244668] e820: reserve RAM buffer [mem 0x09d02000-0x0bffffff]
[ 0.244670] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
[ 0.244672] e820: reserve RAM buffer [mem 0x0b000000-0x0bffffff]
[ 0.244674] e820: reserve RAM buffer [mem 0x57084018-0x57ffffff]
[ 0.244676] e820: reserve RAM buffer [mem 0x57754000-0x57ffffff]
[ 0.244678] e820: reserve RAM buffer [mem 0x59e4a000-0x5bffffff]
[ 0.244680] e820: reserve RAM buffer [mem 0x5aed1000-0x5bffffff]
[ 0.244681] e820: reserve RAM buffer [mem 0x5f000000-0x5fffffff]
[ 0.244683] e820: reserve RAM buffer [mem 0x21f340000-0x21fffffff]
[ 0.244745] pci 0000:0e:00.0: vgaarb: setting as boot VGA device
[ 0.244752] pci 0000:0e:00.0: vgaarb: bridge control possible
[ 0.244757] pci 0000:0e:00.0: vgaarb: VGA device added: 
decodes=io+mem,owns=io+mem,locks=none
[ 0.244766] vgaarb: loaded
[ 0.244904] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[ 0.244914] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[ 0.247404] clocksource: Switched to clocksource tsc-early
[ 0.291107] VFS: Disk quotas dquot_6.6.0
[ 0.291116] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 
bytes)
[ 0.291165] pnp: PnP ACPI init
[ 0.291259] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
[ 0.291315] system 00:01: [mem 0xfeb80000-0xfebfffff] has been reserved
[ 0.291397] system 00:02: [mem 0x60000000-0xdfffffff window] has been 
reserved
[ 0.291768] system 00:04: [io 0x0280-0x028f] has been reserved
[ 0.291775] system 00:04: [io 0x0290-0x029f] has been reserved
[ 0.291781] system 00:04: [io 0x02a0-0x02af] has been reserved
[ 0.291788] system 00:04: [io 0x02b0-0x02bf] has been reserved
[ 0.292052] system 00:05: [io 0x04d0-0x04d1] has been reserved
[ 0.292059] system 00:05: [io 0x040b] has been reserved
[ 0.292065] system 00:05: [io 0x04d6] has been reserved
[ 0.292071] system 00:05: [io 0x0c00-0x0c01] has been reserved
[ 0.292077] system 00:05: [io 0x0c14] has been reserved
[ 0.292082] system 00:05: [io 0x0c50-0x0c51] has been reserved
[ 0.292088] system 00:05: [io 0x0c52] has been reserved
[ 0.292094] system 00:05: [io 0x0c6c] has been reserved
[ 0.292100] system 00:05: [io 0x0c6f] has been reserved
[ 0.292105] system 00:05: [io 0x0cd0-0x0cd1] has been reserved
[ 0.292111] system 00:05: [io 0x0cd2-0x0cd3] has been reserved
[ 0.292117] system 00:05: [io 0x0cd4-0x0cd5] has been reserved
[ 0.292123] system 00:05: [io 0x0cd6-0x0cd7] has been reserved
[ 0.292129] system 00:05: [io 0x0cd8-0x0cdf] has been reserved
[ 0.292135] system 00:05: [io 0x0800-0x089f] has been reserved
[ 0.292141] system 00:05: [io 0x0b00-0x0b0f] has been reserved
[ 0.292147] system 00:05: [io 0x0b20-0x0b3f] has been reserved
[ 0.292153] system 00:05: [io 0x0900-0x090f] has been reserved
[ 0.292159] system 00:05: [io 0x0910-0x091f] has been reserved
[ 0.292165] system 00:05: [mem 0xfec00000-0xfec00fff] could not be 
reserved
[ 0.292172] system 00:05: [mem 0xfec01000-0xfec01fff] could not be 
reserved
[ 0.292179] system 00:05: [mem 0xfedc0000-0xfedc0fff] has been reserved
[ 0.292185] system 00:05: [mem 0xfee00000-0xfee00fff] has been reserved
[ 0.292191] system 00:05: [mem 0xfed80000-0xfed8ffff] could not be 
reserved
[ 0.292198] system 00:05: [mem 0xfec10000-0xfec10fff] has been reserved
[ 0.292204] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[ 0.292682] pnp: PnP ACPI: found 6 devices
[ 0.298941] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, 
max_idle_ns: 2085701024 ns
[ 0.298972] NET: Registered PF_INET protocol family
[ 0.299066] IP idents hash table entries: 131072 (order: 8, 1048576 
bytes, linear)
[ 0.300483] tcp_listen_portaddr_hash hash table entries: 4096 (order: 
4, 65536 bytes, linear)
[ 0.300497] Table-perturb hash table entries: 65536 (order: 6, 262144 
bytes, linear)
[ 0.300506] TCP established hash table entries: 65536 (order: 7, 524288 
bytes, linear)
[ 0.300568] TCP bind hash table entries: 65536 (order: 9, 2097152 
bytes, linear)
[ 0.300703] TCP: Hash tables configured (established 65536 bind 65536)
[ 0.300736] UDP hash table entries: 4096 (order: 6, 262144 bytes, 
linear)
[ 0.300767] UDP-Lite hash table entries: 4096 (order: 6, 262144 bytes, 
linear)
[ 0.300847] NET: Registered PF_UNIX/PF_LOCAL protocol family
[ 0.300938] RPC: Registered named UNIX socket transport module.
[ 0.300944] RPC: Registered udp transport module.
[ 0.300949] RPC: Registered tcp transport module.
[ 0.300953] RPC: Registered tcp-with-tls transport module.
[ 0.300958] RPC: Registered tcp NFSv4.1 backchannel transport module.
[ 0.301436] pci 0000:00:01.6: bridge window [io 0x1000-0x0fff] to [bus 
0d] add_size 1000
[ 0.301446] pci 0000:00:01.6: bridge window [mem 0x00100000-0x000fffff 
64bit pref] to [bus 0d] add_size 200000 add_align 100000
[ 0.301464] pci 0000:00:01.6: bridge window [mem 0xf0200000-0xf03fffff 
64bit pref]: assigned
[ 0.301474] pci 0000:00:01.6: bridge window [io 0x1000-0x1fff]: assigned
[ 0.301481] pci 0000:02:01.0: PCI bridge to [bus 03]
[ 0.301491] pci 0000:02:01.0: bridge window [mem 0xfc400000-0xfc5fffff]
[ 0.301505] pci 0000:02:02.0: PCI bridge to [bus 04]
[ 0.301514] pci 0000:02:02.0: bridge window [mem 0xfc200000-0xfc3fffff]
[ 0.301528] pci 0000:01:00.0: PCI bridge to [bus 02-04]
[ 0.301537] pci 0000:01:00.0: bridge window [mem 0xfc200000-0xfc5fffff]
[ 0.301550] pci 0000:00:01.1: PCI bridge to [bus 01-04]
[ 0.301559] pci 0000:00:01.1: bridge window [mem 0xfc200000-0xfc5fffff]
[ 0.301574] pci 0000:06:00.0: PCI bridge to [bus 07]
[ 0.301591] pci 0000:06:01.0: PCI bridge to [bus 08]
[ 0.301607] pci 0000:06:04.0: PCI bridge to [bus 09]
[ 0.301624] pci 0000:06:05.0: PCI bridge to [bus 0a]
[ 0.301640] pci 0000:06:06.0: PCI bridge to [bus 0b]
[ 0.301649] pci 0000:06:06.0: bridge window [mem 0xfcb00000-0xfcbfffff]
[ 0.301663] pci 0000:06:07.0: PCI bridge to [bus 0c]
[ 0.301669] pci 0000:06:07.0: bridge window [io 0xf000-0xffff]
[ 0.301679] pci 0000:06:07.0: bridge window [mem 0xfca00000-0xfcafffff]
[ 0.301693] pci 0000:05:00.2: PCI bridge to [bus 06-0c]
[ 0.301699] pci 0000:05:00.2: bridge window [io 0xf000-0xffff]
[ 0.301709] pci 0000:05:00.2: bridge window [mem 0xfca00000-0xfcbfffff]
[ 0.301722] pci 0000:00:01.2: PCI bridge to [bus 05-0c]
[ 0.301728] pci 0000:00:01.2: bridge window [io 0xf000-0xffff]
[ 0.301738] pci 0000:00:01.2: bridge window [mem 0xfca00000-0xfccfffff]
[ 0.301751] pci 0000:00:01.6: PCI bridge to [bus 0d]
[ 0.301757] pci 0000:00:01.6: bridge window [io 0x1000-0x1fff]
[ 0.301767] pci 0000:00:01.6: bridge window [mem 0xfce00000-0xfcefffff]
[ 0.301775] pci 0000:00:01.6: bridge window [mem 0xf0200000-0xf03fffff 
64bit pref]
[ 0.301790] pci 0000:00:08.1: PCI bridge to [bus 0e]
[ 0.301800] pci 0000:00:08.1: bridge window [io 0xe000-0xefff]
[ 0.301810] pci 0000:00:08.1: bridge window [mem 0xfc600000-0xfc9fffff]
[ 0.301818] pci 0000:00:08.1: bridge window [mem 0xe0000000-0xf01fffff 
64bit pref]
[ 0.301833] pci 0000:00:08.2: PCI bridge to [bus 0f]
[ 0.301842] pci 0000:00:08.2: bridge window [mem 0xfcd00000-0xfcdfffff]
[ 0.301857] pci_bus 0000:00: resource 4 [io 0x0000-0x03af window]
[ 0.301863] pci_bus 0000:00: resource 5 [io 0x03e0-0x0cf7 window]
[ 0.301869] pci_bus 0000:00: resource 6 [io 0x03b0-0x03df window]
[ 0.301875] pci_bus 0000:00: resource 7 [io 0x0d00-0xffff window]
[ 0.301881] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff 
window]
[ 0.301887] pci_bus 0000:00: resource 9 [mem 0xe0000000-0xfec2ffff 
window]
[ 0.301894] pci_bus 0000:00: resource 10 [mem 0xfee00000-0xffffffff 
window]
[ 0.301900] pci_bus 0000:01: resource 1 [mem 0xfc200000-0xfc5fffff]
[ 0.301906] pci_bus 0000:02: resource 1 [mem 0xfc200000-0xfc5fffff]
[ 0.301912] pci_bus 0000:03: resource 1 [mem 0xfc400000-0xfc5fffff]
[ 0.301918] pci_bus 0000:04: resource 1 [mem 0xfc200000-0xfc3fffff]
[ 0.301924] pci_bus 0000:05: resource 0 [io 0xf000-0xffff]
[ 0.301930] pci_bus 0000:05: resource 1 [mem 0xfca00000-0xfccfffff]
[ 0.301936] pci_bus 0000:06: resource 0 [io 0xf000-0xffff]
[ 0.301941] pci_bus 0000:06: resource 1 [mem 0xfca00000-0xfcbfffff]
[ 0.301948] pci_bus 0000:0b: resource 1 [mem 0xfcb00000-0xfcbfffff]
[ 0.301954] pci_bus 0000:0c: resource 0 [io 0xf000-0xffff]
[ 0.301959] pci_bus 0000:0c: resource 1 [mem 0xfca00000-0xfcafffff]
[ 0.301965] pci_bus 0000:0d: resource 0 [io 0x1000-0x1fff]
[ 0.301971] pci_bus 0000:0d: resource 1 [mem 0xfce00000-0xfcefffff]
[ 0.301977] pci_bus 0000:0d: resource 2 [mem 0xf0200000-0xf03fffff 
64bit pref]
[ 0.301984] pci_bus 0000:0e: resource 0 [io 0xe000-0xefff]
[ 0.301989] pci_bus 0000:0e: resource 1 [mem 0xfc600000-0xfc9fffff]
[ 0.301995] pci_bus 0000:0e: resource 2 [mem 0xe0000000-0xf01fffff 
64bit pref]
[ 0.302002] pci_bus 0000:0f: resource 1 [mem 0xfcd00000-0xfcdfffff]
[ 0.302294] pci 0000:0e:00.1: D0 power state depends on 0000:0e:00.0
[ 0.302312] pci 0000:0e:00.3: extending delay after power-on from D3hot 
to 20 msec
[ 0.302522] pci 0000:0e:00.4: extending delay after power-on from D3hot 
to 20 msec
[ 0.302634] PCI: CLS 64 bytes, default 64
[ 0.302654] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[ 0.302659] software IO TLB: mapped [mem 
0x0000000053084000-0x0000000057084000] (64MB)
[ 0.302685] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 
163840 ms ovfl timer
[ 0.302691] RAPL PMU: hw unit of domain package 2^-16 Joules
[ 0.302748] amd_uncore: 4 amd_df counters detected
[ 0.302756] amd_uncore: 6 amd_l3 counters detected
[ 0.303818] Initialise system trusted keyrings
[ 0.303854] workingset: timestamp_bits=40 max_order=21 bucket_order=0
[ 0.303977] NFS: Registering the id_resolver key type
[ 0.303984] Key type id_resolver registered
[ 0.303989] Key type id_legacy registered
[ 0.316761] Key type asymmetric registered
[ 0.316767] Asymmetric key parser 'x509' registered
[ 0.316787] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 251)
[ 0.316794] io scheduler mq-deadline registered
[ 0.316799] io scheduler kyber registered
[ 0.316953] pcieport 0000:00:01.1: PME: Signaling with IRQ 25
[ 0.317122] pcieport 0000:00:01.2: PME: Signaling with IRQ 26
[ 0.317288] pcieport 0000:00:01.6: PME: Signaling with IRQ 27
[ 0.317473] pcieport 0000:00:08.1: PME: Signaling with IRQ 28
[ 0.317689] pcieport 0000:00:08.2: PME: Signaling with IRQ 29
[ 0.319347] input: Power Button as 
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[ 0.319381] ACPI: button: Power Button [PWRB]
[ 0.319427] input: Power Button as 
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[ 0.319489] ACPI: button: Power Button [PWRF]
[ 0.319550] ACPI: video: Video Device [VGA] (multi-head: yes rom: no 
post: no)
[ 0.319734] input: Video Bus as 
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:01/LNXVIDEO:00/input/input2
[ 0.319808] ACPI: video: Video Device [VGA1] (multi-head: yes rom: no 
post: no)
[ 0.319874] input: Video Bus as 
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:0f/LNXVIDEO:01/input/input3
[ 0.320512] Could not retrieve perf counters (-19)
[ 0.320668] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[ 0.321229] Non-volatile memory driver v1.3
[ 0.321234] Linux agpgart interface v0.103
[ 0.321672] ACPI: bus type drm_connector registered
[ 0.321692] [drm] amdgpu kernel modesetting enabled.
[ 0.321839] [drm] initializing kernel modesetting (RAVEN 0x1002:0x15DD 
0x1002:0x15DD 0xC6).
[ 0.321853] [drm] register mmio base: 0xFC900000
[ 0.321858] [drm] register mmio size: 524288
[ 0.321889] [drm] add ip block number 0 <soc15_common>
[ 0.321893] [drm] add ip block number 1 <gmc_v9_0>
[ 0.321898] [drm] add ip block number 2 <vega10_ih>
[ 0.321902] [drm] add ip block number 3 <psp>
[ 0.321907] [drm] add ip block number 4 <powerplay>
[ 0.321911] [drm] add ip block number 5 <dm>
[ 0.321915] [drm] add ip block number 6 <gfx_v9_0>
[ 0.321920] [drm] add ip block number 7 <sdma_v4_0>
[ 0.321924] [drm] add ip block number 8 <vcn_v1_0>
[ 0.344764] [drm] BIOS signature incorrect 0 0
[ 0.344785] amdgpu 0000:0e:00.0: amdgpu: Fetched VBIOS from ROM BAR
[ 0.344791] amdgpu: ATOM BIOS: 113-RAVEN-113
[ 0.344854] amdgpu 0000:0e:00.0: vgaarb: deactivate vga console
[ 0.344860] amdgpu 0000:0e:00.0: amdgpu: Trusted Memory Zone (TMZ) 
feature enabled
[ 0.344885] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, 
fragment size is 9-bit
[ 0.344896] amdgpu 0000:0e:00.0: amdgpu: VRAM: 2048M 0x000000F400000000 
- 0x000000F47FFFFFFF (2048M used)
[ 0.344904] amdgpu 0000:0e:00.0: amdgpu: GART: 1024M 0x0000000000000000 
- 0x000000003FFFFFFF
[ 0.344915] [drm] Detected VRAM RAM=2048M, BAR=2048M
[ 0.344920] [drm] RAM width 128bits DDR4
[ 0.345024] [drm] amdgpu: 2048M of VRAM memory ready
[ 0.345029] [drm] amdgpu: 2923M of GTT memory ready.
[ 0.345044] [drm] GART: num cpu pages 262144, num gpu pages 262144
[ 0.345178] [drm] PCIE GART of 1024M enabled.
[ 0.345182] [drm] PTB located at 0x000000F400A00000
[ 0.345443] amdgpu: hwmgr_sw_init smu backed is smu10_smu
[ 0.345881] [drm] Found VCN firmware Version ENC: 1.15 DEC: 3 VEP: 0 
Revision: 0
[ 0.366435] amdgpu 0000:0e:00.0: amdgpu: reserve 0x400000 from 
0xf47fc00000 for PSP TMR
[ 0.432732] amdgpu 0000:0e:00.0: amdgpu: RAS: optional ras ta ucode is 
not available
[ 0.439732] amdgpu 0000:0e:00.0: amdgpu: RAP: optional rap ta ucode is 
not available
[ 0.439740] amdgpu 0000:0e:00.0: amdgpu: SECUREDISPLAY: securedisplay 
ta ucode is not available
[ 0.440750] [drm] DM_PPLIB: values for F clock
[ 0.440756] [drm] DM_PPLIB: 1633000 in kHz, 4399 in mV
[ 0.440761] [drm] DM_PPLIB: values for DCF clock
[ 0.440765] [drm] DM_PPLIB: 300000 in kHz, 3649 in mV
[ 0.440770] [drm] DM_PPLIB: 600000 in kHz, 4074 in mV
[ 0.440774] [drm] DM_PPLIB: 626000 in kHz, 4250 in mV
[ 0.440779] [drm] DM_PPLIB: 654000 in kHz, 4399 in mV
[ 0.441028] [drm] Display Core v3.2.310 initialized on DCN 1.0
[ 0.513098] [drm] kiq ring mec 2 pipe 1 q 0
[ 0.526847] amdgpu 0000:0e:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 
11, active_cu_number 11
[ 0.526857] amdgpu 0000:0e:00.0: amdgpu: ring gfx uses VM inv eng 0 on 
hub 0
[ 0.526864] amdgpu 0000:0e:00.0: amdgpu: ring comp_1.0.0 uses VM inv 
eng 1 on hub 0
[ 0.526870] amdgpu 0000:0e:00.0: amdgpu: ring comp_1.1.0 uses VM inv 
eng 4 on hub 0
[ 0.526877] amdgpu 0000:0e:00.0: amdgpu: ring comp_1.2.0 uses VM inv 
eng 5 on hub 0
[ 0.526884] amdgpu 0000:0e:00.0: amdgpu: ring comp_1.3.0 uses VM inv 
eng 6 on hub 0
[ 0.526890] amdgpu 0000:0e:00.0: amdgpu: ring comp_1.0.1 uses VM inv 
eng 7 on hub 0
[ 0.526896] amdgpu 0000:0e:00.0: amdgpu: ring comp_1.1.1 uses VM inv 
eng 8 on hub 0
[ 0.526903] amdgpu 0000:0e:00.0: amdgpu: ring comp_1.2.1 uses VM inv 
eng 9 on hub 0
[ 0.526909] amdgpu 0000:0e:00.0: amdgpu: ring comp_1.3.1 uses VM inv 
eng 10 on hub 0
[ 0.526916] amdgpu 0000:0e:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv 
eng 11 on hub 0
[ 0.526923] amdgpu 0000:0e:00.0: amdgpu: ring sdma0 uses VM inv eng 0 
on hub 8
[ 0.526929] amdgpu 0000:0e:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 
on hub 8
[ 0.526935] amdgpu 0000:0e:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 
4 on hub 8
[ 0.526942] amdgpu 0000:0e:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 
5 on hub 8
[ 0.526948] amdgpu 0000:0e:00.0: amdgpu: ring jpeg_dec uses VM inv eng 
6 on hub 8
[ 0.529798] amdgpu: pp_dpm_get_sclk_od was not implemented.
[ 0.529805] amdgpu: pp_dpm_get_mclk_od was not implemented.
[ 0.529910] amdgpu 0000:0e:00.0: amdgpu: Runtime PM not available
[ 0.530214] [drm] Initialized amdgpu 3.60.0 for 0000:0e:00.0 on minor 0
[ 0.535115] fbcon: amdgpudrmfb (fb0) is primary device
[ 0.604452] Console: switching to colour frame buffer device 240x67
[ 0.638269] amdgpu 0000:0e:00.0: [drm] fb0: amdgpudrmfb frame buffer 
device
[ 0.640351] loop: module loaded
[ 0.640559] ahci 0000:05:00.1: version 3.0
[ 0.640611] nvme nvme0: pci function 0000:0d:00.0
[ 0.640701] ahci 0000:05:00.1: SSS flag set, parallel bus scan disabled
[ 0.640773] ahci 0000:05:00.1: AHCI vers 0001.0301, 32 command slots, 6 
Gbps, SATA mode
[ 0.640789] ahci 0000:05:00.1: 4/8 ports implemented (port mask 0x33)
[ 0.640803] ahci 0000:05:00.1: flags: 64bit ncq sntf stag pm led clo 
only pmp pio slum part sxs deso sadm sds apst
[ 0.641445] scsi host0: ahci
[ 0.641553] scsi host1: ahci
[ 0.641654] scsi host2: ahci
[ 0.641757] scsi host3: ahci
[ 0.641858] scsi host4: ahci
[ 0.641959] scsi host5: ahci
[ 0.642065] scsi host6: ahci
[ 0.642164] scsi host7: ahci
[ 0.642213] ata1: SATA max UDMA/133 abar m131072@0xfcc80000 port 
0xfcc80100 irq 43 lpm-pol 3
[ 0.642230] ata2: SATA max UDMA/133 abar m131072@0xfcc80000 port 
0xfcc80180 irq 43 lpm-pol 3
[ 0.642245] ata3: DUMMY
[ 0.642252] ata4: DUMMY
[ 0.642260] ata5: SATA max UDMA/133 abar m131072@0xfcc80000 port 
0xfcc80300 irq 43 lpm-pol 3
[ 0.642276] ata6: SATA max UDMA/133 abar m131072@0xfcc80000 port 
0xfcc80380 irq 43 lpm-pol 3
[ 0.642291] ata7: DUMMY
[ 0.642298] ata8: DUMMY
[ 0.643975] nvme nvme0: missing or invalid SUBNQN field.
[ 0.645524] nvme nvme0: 8/0/0 default/read/poll queues
[ 0.646127] nvme nvme0: Ignoring bogus Namespace Identifiers
[ 0.647109] nvme0n1: p1 p2 p3 p4 p5 p6
[ 0.653098] ahci 0000:0f:00.0: AHCI vers 0001.0301, 32 command slots, 6 
Gbps, SATA mode
[ 0.653132] ahci 0000:0f:00.0: 1/1 ports implemented (port mask 0x1)
[ 0.653158] ahci 0000:0f:00.0: flags: 64bit ncq sntf ilck pm led clo 
only pmp fbs pio slum part
[ 0.653412] scsi host8: ahci
[ 0.653481] ata9: SATA max UDMA/133 abar m2048@0xfcd00000 port 
0xfcd00100 irq 46 lpm-pol 3
[ 0.653874] e100: Intel(R) PRO/100 Network Driver
[ 0.653886] e100: Copyright(c) 1999-2006 Intel Corporation
[ 0.653909] e1000: Intel(R) PRO/1000 Network Driver
[ 0.653919] e1000: Copyright (c) 1999-2006 Intel Corporation.
[ 0.653943] e1000e: Intel(R) PRO/1000 Network Driver
[ 0.653953] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[ 0.653980] sky2: driver version 1.30
[ 0.654208] xhci_hcd 0000:05:00.0: xHCI Host Controller
[ 0.654255] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus 
number 1
[ 0.710176] xhci_hcd 0000:05:00.0: hcc params 0x0200ef81 hci version 
0x110 quirks 0x0000000000000010
[ 0.712498] xhci_hcd 0000:05:00.0: xHCI Host Controller
[ 0.713174] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus 
number 2
[ 0.713715] xhci_hcd 0000:05:00.0: Host supports USB 3.1 Enhanced 
SuperSpeed
[ 0.714294] usb usb1: New USB device found, idVendor=1d6b, 
idProduct=0002, bcdDevice= 6.13
[ 0.714804] usb usb1: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[ 0.715306] usb usb1: Product: xHCI Host Controller
[ 0.715799] usb usb1: Manufacturer: Linux 6.13.4 xhci-hcd
[ 0.716289] usb usb1: SerialNumber: 0000:05:00.0
[ 0.716909] hub 1-0:1.0: USB hub found
[ 0.717425] hub 1-0:1.0: 10 ports detected
[ 0.718723] usb usb2: We don't know the algorithms for LPM for this 
host, disabling LPM.
[ 0.720516] usb usb2: New USB device found, idVendor=1d6b, 
idProduct=0003, bcdDevice= 6.13
[ 0.721112] usb usb2: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[ 0.721610] usb usb2: Product: xHCI Host Controller
[ 0.722085] usb usb2: Manufacturer: Linux 6.13.4 xhci-hcd
[ 0.722550] usb usb2: SerialNumber: 0000:05:00.0
[ 0.723147] hub 2-0:1.0: USB hub found
[ 0.723631] hub 2-0:1.0: 4 ports detected
[ 0.724875] xhci_hcd 0000:0e:00.3: xHCI Host Controller
[ 0.725406] xhci_hcd 0000:0e:00.3: new USB bus registered, assigned bus 
number 3
[ 0.726073] xhci_hcd 0000:0e:00.3: hcc params 0x0270ffe5 hci version 
0x110 quirks 0x0000000840000010
[ 0.726894] xhci_hcd 0000:0e:00.3: xHCI Host Controller
[ 0.727410] xhci_hcd 0000:0e:00.3: new USB bus registered, assigned bus 
number 4
[ 0.727889] xhci_hcd 0000:0e:00.3: Host supports USB 3.1 Enhanced 
SuperSpeed
[ 0.728423] usb usb3: New USB device found, idVendor=1d6b, 
idProduct=0002, bcdDevice= 6.13
[ 0.728888] usb usb3: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[ 0.729341] usb usb3: Product: xHCI Host Controller
[ 0.729794] usb usb3: Manufacturer: Linux 6.13.4 xhci-hcd
[ 0.730254] usb usb3: SerialNumber: 0000:0e:00.3
[ 0.730837] hub 3-0:1.0: USB hub found
[ 0.731322] hub 3-0:1.0: 4 ports detected
[ 0.732137] usb usb4: We don't know the algorithms for LPM for this 
host, disabling LPM.
[ 0.732622] usb usb4: New USB device found, idVendor=1d6b, 
idProduct=0003, bcdDevice= 6.13
[ 0.733079] usb usb4: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[ 0.733529] usb usb4: Product: xHCI Host Controller
[ 0.733987] usb usb4: Manufacturer: Linux 6.13.4 xhci-hcd
[ 0.734441] usb usb4: SerialNumber: 0000:0e:00.3
[ 0.735021] hub 4-0:1.0: USB hub found
[ 0.735522] hub 4-0:1.0: 4 ports detected
[ 0.736634] xhci_hcd 0000:0e:00.4: xHCI Host Controller
[ 0.737256] xhci_hcd 0000:0e:00.4: new USB bus registered, assigned bus 
number 5
[ 0.737934] xhci_hcd 0000:0e:00.4: hcc params 0x0260ffe5 hci version 
0x110 quirks 0x0000000840000010
[ 0.738720] xhci_hcd 0000:0e:00.4: xHCI Host Controller
[ 0.739261] xhci_hcd 0000:0e:00.4: new USB bus registered, assigned bus 
number 6
[ 0.739756] xhci_hcd 0000:0e:00.4: Host supports USB 3.1 Enhanced 
SuperSpeed
[ 0.740306] usb usb5: New USB device found, idVendor=1d6b, 
idProduct=0002, bcdDevice= 6.13
[ 0.740788] usb usb5: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[ 0.741262] usb usb5: Product: xHCI Host Controller
[ 0.741730] usb usb5: Manufacturer: Linux 6.13.4 xhci-hcd
[ 0.742200] usb usb5: SerialNumber: 0000:0e:00.4
[ 0.742790] hub 5-0:1.0: USB hub found
[ 0.743298] hub 5-0:1.0: 1 port detected
[ 0.743900] usb usb6: We don't know the algorithms for LPM for this 
host, disabling LPM.
[ 0.744422] usb usb6: New USB device found, idVendor=1d6b, 
idProduct=0003, bcdDevice= 6.13
[ 0.744910] usb usb6: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[ 0.745375] usb usb6: Product: xHCI Host Controller
[ 0.745834] usb usb6: Manufacturer: Linux 6.13.4 xhci-hcd
[ 0.746290] usb usb6: SerialNumber: 0000:0e:00.4
[ 0.746863] hub 6-0:1.0: USB hub found
[ 0.747352] hub 6-0:1.0: 1 port detected
[ 0.747949] usbcore: registered new interface driver usblp
[ 0.748450] usbcore: registered new interface driver usb-storage
[ 0.748959] i8042: PNP: No PS/2 controller found.
[ 0.749570] rtc_cmos 00:03: RTC can wake from S4
[ 0.750434] rtc_cmos 00:03: registered as rtc0
[ 0.750945] rtc_cmos 00:03: alarms up to one month, y3k, 114 bytes 
nvram, hpet irqs
[ 0.751487] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) 
initialised: dm-devel@lists.linux.dev
[ 0.752000] hid: raw HID events driver (C) Jiri Kosina
[ 0.752637] usbcore: registered new interface driver usbhid
[ 0.753326] usbhid: USB HID core driver
[ 0.754812] Initializing XFRM netlink socket
[ 0.755442] NET: Registered PF_INET6 protocol family
[ 0.756136] Segment Routing with IPv6
[ 0.756647] In-situ OAM (IOAM) with IPv6
[ 0.757147] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[ 0.757935] NET: Registered PF_PACKET protocol family
[ 0.758455] Key type dns_resolver registered
[ 0.759763] microcode: Current revision: 0x08101016
[ 0.759984] snd_hda_intel 0000:0e:00.1: bound 0000:0e:00.0 (ops 
amdgpu_dm_audio_component_bind_ops)
[ 0.760875] IPI shorthand broadcast: enabled
[ 0.761297] input: HD-Audio Generic HDMI/DP,pcm=3 as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.1/sound/card0/input4
[ 0.761918] input: HD-Audio Generic HDMI/DP,pcm=7 as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.1/sound/card0/input5
[ 0.762473] input: HD-Audio Generic HDMI/DP,pcm=8 as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.1/sound/card0/input6
[ 0.767597] sched_clock: Marking stable (766552450, 
507622)->(780141950, -13081878)
[ 0.768459] registered taskstats version 1
[ 0.768984] Loading compiled-in X.509 certificates
[ 0.769673] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC1220: 
line_outs=3 (0x14/0x15/0x16/0x0/0x0) type:line
[ 0.770160] snd_hda_codec_realtek hdaudioC1D0: speaker_outs=0 
(0x0/0x0/0x0/0x0/0x0)
[ 0.770636] snd_hda_codec_realtek hdaudioC1D0: hp_outs=1 
(0x1b/0x0/0x0/0x0/0x0)
[ 0.771101] snd_hda_codec_realtek hdaudioC1D0: mono: mono_out=0x0
[ 0.771565] snd_hda_codec_realtek hdaudioC1D0: dig-out=0x1e/0x0
[ 0.772080] snd_hda_codec_realtek hdaudioC1D0: inputs:
[ 0.772789] snd_hda_codec_realtek hdaudioC1D0: Rear Mic=0x18
[ 0.773335] snd_hda_codec_realtek hdaudioC1D0: Front Mic=0x19
[ 0.773820] snd_hda_codec_realtek hdaudioC1D0: Line=0x1a
[ 0.774314] Demotion targets for Node 0: null
[ 0.774870] PM: Magic number: 9:568:139
[ 0.775349] usb usb4-port4: hash matches
[ 0.775829] acpi device:10: hash matches
[ 0.776282] printk: legacy console [netcon0] enabled
[ 0.776717] netconsole: network logging started
[ 0.777263] acpi_cpufreq: overriding BIOS provided _PSD data
[ 0.778051] cfg80211: Loading compiled-in X.509 certificates for 
regulatory database
[ 0.778581] kworker/u32:9 (144) used greatest stack depth: 14456 bytes 
left
[ 0.778806] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[ 0.779687] Loaded X.509 cert 'wens: 
61c038651aabdcf94bd0ac7ff06c7248db18c600'
[ 0.780175] platform regulatory.0: Direct firmware load for 
regulatory.db failed with error -2
[ 0.780637] cfg80211: failed to load regulatory.db
[ 0.780684] clk: Disabling unused clocks
[ 0.781546] ALSA device list:
[ 0.782001] #0: HD-Audio Generic at 0xfc988000 irq 74
[ 0.800109] input: HD-Audio Generic Rear Mic as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.6/sound/card1/input7
[ 0.800740] input: HD-Audio Generic Front Mic as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.6/sound/card1/input8
[ 0.801274] input: HD-Audio Generic Line as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.6/sound/card1/input9
[ 0.801791] input: HD-Audio Generic Line Out Front as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.6/sound/card1/input10
[ 0.802311] input: HD-Audio Generic Line Out Surround as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.6/sound/card1/input11
[ 0.802865] input: HD-Audio Generic Line Out CLFE as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.6/sound/card1/input12
[ 0.803532] input: HD-Audio Generic Front Headphone as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.6/sound/card1/input13
[ 0.957818] ata9: SATA link down (SStatus 0 SControl 300)
[ 0.966906] usb 3-2: new full-speed USB device number 2 using xhci_hcd
[ 1.020095] usb 1-6: new full-speed USB device number 2 using xhci_hcd
[ 1.111524] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[ 1.113211] ata1.00: ATA-10: ST4000VN008-2DR166, SC60, max UDMA/133
[ 1.114157] ata1.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 
32), AA
[ 1.114698] ata1.00: Features: NCQ-sndrcv
[ 1.116354] ata1.00: configured for UDMA/133
[ 1.118469] usb 3-2: New USB device found, idVendor=046d, 
idProduct=c08f, bcdDevice=45.01
[ 1.119052] usb 3-2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[ 1.119544] usb 3-2: Product: G403 HERO Gaming Mouse
[ 1.120023] usb 3-2: Manufacturer: Logitech
[ 1.120496] usb 3-2: SerialNumber: 197431693131
[ 1.127046] scsi 0:0:0:0: Direct-Access ATA ST4000VN008-2DR1 SC60 PQ: 0 
ANSI: 5
[ 1.127865] sd 0:0:0:0: Attached scsi generic sg0 type 0
[ 1.127880] sd 0:0:0:0: [sda] 7814037168 512-byte logical blocks: (4.00 
TB/3.64 TiB)
[ 1.128944] sd 0:0:0:0: [sda] 4096-byte physical blocks
[ 1.129457] sd 0:0:0:0: [sda] Write Protect is off
[ 1.129951] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[ 1.129966] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 1.130480] sd 0:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
[ 1.141103] input: Logitech G403 HERO Gaming Mouse as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.3/usb3/3-2/3-2:1.0/0003:046D:C08F.0001/input/input14
[ 1.141799] hid-generic 0003:046D:C08F.0001: input,hidraw0: USB HID 
v1.11 Mouse [Logitech G403 HERO Gaming Mouse] on 
usb-0000:0e:00.3-2/input0
[ 1.149865] input: Logitech G403 HERO Gaming Mouse Keyboard as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.3/usb3/3-2/3-2:1.1/0003:046D:C08F.0002/input/input15
[ 1.188543] sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8
[ 1.190778] sd 0:0:0:0: [sda] Attached SCSI disk
[ 1.200840] hid-generic 0003:046D:C08F.0002: input,hiddev96,hidraw1: 
USB HID v1.11 Keyboard [Logitech G403 HERO Gaming Mouse] on 
usb-0000:0e:00.3-2/input1
[ 1.313514] usb 3-3: new full-speed USB device number 3 using xhci_hcd
[ 1.359528] tsc: Refined TSC clocksource calibration: 3899.981 MHz
[ 1.360184] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 
0x706e919c8ed, max_idle_ns: 881591200829 ns
[ 1.360781] clocksource: Switched to clocksource tsc
[ 1.384626] usb 1-6: New USB device found, idVendor=8087, 
idProduct=0aa7, bcdDevice= 0.01
[ 1.385300] usb 1-6: New USB device strings: Mfr=0, Product=0, 
SerialNumber=0
[ 1.436601] ata2: SATA link down (SStatus 0 SControl 300)
[ 1.464476] usb 3-3: New USB device found, idVendor=046d, 
idProduct=c33c, bcdDevice=19.01
[ 1.465148] usb 3-3: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[ 1.465734] usb 3-3: Product: G513 RGB MECHANICAL GAMING KEYBOARD
[ 1.466278] usb 3-3: Manufacturer: Logitech
[ 1.466821] usb 3-3: SerialNumber: 096A30493232
[ 1.485705] input: Logitech G513 RGB MECHANICAL GAMING KEYBOARD as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.3/usb3/3-3/3-3:1.0/0003:046D:C33C.0003/input/input18
[ 1.536659] hid-generic 0003:046D:C33C.0003: input,hidraw2: USB HID 
v1.11 Keyboard [Logitech G513 RGB MECHANICAL GAMING KEYBOARD] on 
usb-0000:0e:00.3-3/input0
[ 1.544744] input: Logitech G513 RGB MECHANICAL GAMING KEYBOARD 
Keyboard as 
/devices/pci0000:00/0000:00:08.1/0000:0e:00.3/usb3/3-3/3-3:1.1/0003:046D:C33C.0004/input/input19
[ 1.595613] hid-generic 0003:046D:C33C.0004: input,hiddev97,hidraw3: 
USB HID v1.11 Keyboard [Logitech G513 RGB MECHANICAL GAMING KEYBOARD] 
on usb-0000:0e:00.3-3/input1
[ 1.740587] ata5: SATA link down (SStatus 0 SControl 330)
[ 2.044586] ata6: SATA link down (SStatus 0 SControl 330)
[ 2.045371] md: Waiting for all devices to be available before 
autodetect
[ 2.046262] md: If you don't use raid, use raid=noautodetect
[ 2.046985] md: Autodetecting RAID arrays.
[ 2.047649] md: autorun ...
[ 2.048282] md: ... autorun DONE.
[ 2.051398] EXT4-fs (nvme0n1p5): mounted filesystem 
010dcc07-2ae7-44a9-ad6d-c39d6da3f97d ro with ordered data mode. Quota 
mode: none.
[ 2.052137] VFS: Mounted root (ext4 filesystem) readonly on device 
259:5.
[ 2.053095] devtmpfs: mounted
[ 2.054221] Freeing unused kernel image (initmem) memory: 2932K
[ 2.055009] Write protecting the kernel read-only data: 34816k
[ 2.055918] Freeing unused kernel image (rodata/data gap) memory: 928K
[ 2.119309] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[ 2.120039] Run /sbin/init as init process
[ 2.121168] with arguments:
[ 2.121170] /sbin/init
[ 2.121172] with environment:
[ 2.121173] HOME=/
[ 2.121175] TERM=linux
[ 2.121176] BOOT_IMAGE=/boot/vmlinuz-6.13.4-lfs-12.3
[ 2.143749] stty (160) used greatest stack depth: 13064 bytes left
[ 2.166506] sed (173) used greatest stack depth: 12888 bytes left
[ 2.256481] udevd[286]: Starting systemd-udevd version 257.3
[ 2.264563] udevd[287]: Using default interface naming scheme 'v257'.
[ 4.157540] EXT4-fs (nvme0n1p5): re-mounted 
010dcc07-2ae7-44a9-ad6d-c39d6da3f97d ro. Quota mode: none.
[ 4.355625] EXT4-fs (nvme0n1p5): re-mounted 
010dcc07-2ae7-44a9-ad6d-c39d6da3f97d r/w. Quota mode: none.
[ 4.418096] EXT4-fs (nvme0n1p3): mounted filesystem 
4776d5be-2b47-4fb2-b046-96bed51290f6 r/w with ordered data mode. Quota 
mode: none.
[ 4.485988] EXT4-fs (sda3): mounted filesystem 
8b7415e2-a605-42c0-a983-eb074c2741ef r/w with ordered data mode. Quota 
mode: none.
[ 4.596647] Adding 16777212k swap on /swapfile. Priority:-2 extents:197 
across:50429952k SS
[ 5.070428] setfont (557) used greatest stack depth: 12688 bytes left




