<script setup>
const colorMode = useColorMode()
</script>

<template>
  <UButton color="primary" @click="colorMode.preference = colorMode.preference === 'dark' ? 'light' : 'dark'">
    Toggle Theme
  </UButton>
</template>
